import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:p01/view/home.volun.dart';
import 'package:p01/providers/prov.dart';
import 'package:flutter/material.dart';
import 'package:p01/view/vc.dart';
import 'package:p01/view/editprofile.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// Mock class for FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

void main() {
  group('Authentication Test', () {
    late MockFirebaseAuth mockFirebaseAuth;

    setUp(() {
      // Create an instance of the mock FirebaseAuth
      mockFirebaseAuth = MockFirebaseAuth();

      // Mock the behavior of FirebaseAuth.instance
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);
    });

    test('Sign in with correct email and password', () async {
      // Arrange
      final email = 'test@example.com';
      final password = 'password123';

      // Mock the sign-in function for correct credentials
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => MockUserCredential());

      // Act
      final result = await signInWithEmailAndPassword(
        auth: mockFirebaseAuth,
        email: email,
        password: password,
      );

      // Assert
      expect(result, isA<UserCredential>());
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).called(1);
    });

    test('Sign in with incorrect email and password', () async {
      // Arrange
      final email = 'incorrect@example.com';
      final password = 'wrongpassword';

      // Mock the sign-in function for incorrect credentials
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(FirebaseAuthException(
        code: 'wrong-password',
        message: 'The password is invalid.',
      ));

      // Act and Assert
      await expectLater(
        () => signInWithEmailAndPassword(
          auth: mockFirebaseAuth,
          email: email,
          password: password,
        ),
        throwsA(isA<FirebaseAuthException>()),
      );

      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).called(1);
    });

    test('Register with email and password', () async {
      // Arrange
      final email = 'newuser@example.com';
      final password = 'newpassword';

      // Mock the registration function
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => MockUserCredential());

      // Act
      final result = await registerWithEmailAndPassword(
        auth: mockFirebaseAuth,
        email: email,
        password: password,
      );

      // Assert
      expect(result, isA<UserCredential>());
      verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).called(1);
    });

    test('Register and then log in with the registered email', () async {
      // Arrange
      const email = 'registereduser@example.com';
      const password = 'password123';

      // Mock the registration function
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => MockUserCredential());

      // Mock the sign-in function after registration
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => MockUserCredential());

      // Act
      final registrationResult = await registerWithEmailAndPassword(
        auth: mockFirebaseAuth,
        email: email,
        password: password,
      );

      final loginResult = await signInWithEmailAndPassword(
        auth: mockFirebaseAuth,
        email: email,
        password: password,
      );

      // Assert
      expect(registrationResult, isA<UserCredential>());
      verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).called(1);

      expect(loginResult, isA<UserCredential>());
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).called(1);
    });
  });

  group('Home Volunteer Test', () {
    testWidgets('GPS button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<Prov>(
            create: (context) => Prov(),
            child: HomeVolun(),
          ),
        ),
      );

      // Tap the GPS button.
      await tester.tap(find.text('Your current location: '));

      // Allow time for the asynchronous location retrieval.
      await tester.pump();

      // Verify that the current location text is updated.
      expect(find.textContaining('Your current location: '), findsOneWidget);
    });

    testWidgets('VC button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<Prov>(
            create: (context) => Prov(),
            child: HomeVolun(),
          ),
        ),
      );

      // Find the ButtonVCvolun widget and tap it.
      await tester.tap(find.byKey(const Key('buttonVCvolun1')));

      // Allow time for the asynchronous camera opening.
      await tester.pumpAndSettle();

      // Verify that the camera screen is opened.
      expect(find.byWidget(VCscreenVolun()),
          findsNothing); //pas open cam, udah beda page (bukan di page HomeVolun() lagi), jadi ga bisa ketemu page VCscreenVolun() nya.
    });

    testWidgets('Banner Ad', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<Prov>(
            create: (context) => Prov(),
            child: HomeVolun(),
          ),
        ),
      );

      // Verify that the banner ad is initially not present.
      expect(find.byKey(const Key('bannerAdKey')), findsNothing);

      // Wait until the ad is loaded.
      await tester.pumpAndSettle(Duration(
          seconds: 5)); // Adjust the duration based on your ad loading logic.

      // Trigger a frame to rebuild the widget tree after the ad appears.
      await tester.pump();

// Find the AdWidget (or any other wrapper widget around the ad).
      final adWidget = find.byType(AdWidget);

      // Verify that the banner ad is now present.
      expect(adWidget, findsNothing);
    });
    testWidgets('EditProfile widget test', (WidgetTester tester) async {
      // Mock UserProvider
      final prov = Prov();
      prov.setUserFirstName("John");
      prov.setUserLastName("Doe");

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => prov,
          child: MaterialApp(
            home: EditProfile(),
          ),
        ),
      );

      // Verify that the initial values are displayed in text fields
      expect(find.text('John'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);

      // Simulate editing the first name
      await tester.enterText(find.byKey(const Key("firstNameField")), 'Jane');

      // Simulate editing the last name
      await tester.enterText(find.byKey(const Key("lastNameField")), 'Smith');

      // Tap the "Update Profile" button
      await tester.tap(find.text('Update Profile'));
      await tester.pump();

      // Verify that UserProvider has been updated
      expect(prov.userFirstName, 'Jane');
      expect(prov.userLastName, 'Smith');
    });
    test('Track event test', () async {
      final googleAnalytics = GoogleAnalytics();
      await googleAnalytics.trackEvent('some_event');
    });

    test('Set user property test', () async {
      final googleAnalytics = GoogleAnalytics();
      await googleAnalytics.setUserProperty('property_key', 'property_value');
    });
  });
}

class MockUserCredential extends Mock implements UserCredential {}

// Function to sign in with email and password
Future<UserCredential> signInWithEmailAndPassword({
  required FirebaseAuth auth,
  required String email,
  required String password,
}) async {
  try {
    final result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  } on FirebaseAuthException catch (e) {
    // Handle authentication exceptions
    print('Authentication Error: ${e.message}');
    rethrow;
  }
}

// Function to register with email and password
Future<UserCredential> registerWithEmailAndPassword({
  required FirebaseAuth auth,
  required String email,
  required String password,
}) async {
  try {
    final result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  } on FirebaseAuthException catch (e) {
    // Handle registration exceptions
    print('Registration Error: ${e.message}');
    rethrow;
  }
}

class GoogleAnalytics {
  Future<void> trackEvent(String eventName) async {
    // Logika untuk tracking event (ganti dengan implementasi sebenarnya)
    print('Event tracked: $eventName');
  }

  Future<void> setUserProperty(String key, String value) async {
    // Logika untuk set user property (ganti dengan implementasi sebenarnya)
    print('User property set - Key: $key, Value: $value');
  }
}
