import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Mock class for FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

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
