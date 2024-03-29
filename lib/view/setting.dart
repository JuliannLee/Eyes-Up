import 'package:flutter/material.dart';
import 'package:p01/utils/global.colors.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:p01/view/editprofile.dart';
import 'package:p01/view/login.dart';
import 'package:p01/view/about.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Language _selectedDropdownLanguage = Languages.english;

  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Text("${language.name} (${language.isoCode})"),
        )
      ],
    );
  }
  Future<void> signOut() async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    await auth.signOut(); // Sign out from Firebase
    await googleSignIn.signOut(); // Sign out from Google Sign-In

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
      (Route<dynamic> route) => false,
    );
  } catch (e) {
    print("Error signing out: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Settings'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const ListTile(
                      title: Text(
                        "Profile",
                        style: TextStyle(color: Colors.blue, fontSize: 22),
                      ),
                    ),
                    ListTile(
                      title: InkWell(
                        child: const Text(
                          "Personal Details",
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfile()),
                        ),
                      ),
                      leading: const Icon(
                        Icons.person,
                        size: 25,
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        "Notifications",
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Icon(
                        Icons.notifications,
                        size: 25,
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        "Change Themes",
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Icon(
                        Icons.light_mode,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                // ignore: avoid_unnecessary_containers
                Container(
                  // height: 150,
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text(
                          "Languages",
                          style: TextStyle(color: Colors.blue, fontSize: 22),
                        ),
                      ),
                      ListTile(
                        title: const Text("Select Language",
                            style: TextStyle(fontSize: 16)),
                        trailing: SizedBox(
                          width: 150,
                          child: LanguagePickerDropdown(
                            initialValue: Languages.english,
                            itemBuilder: _buildDropdownItem,
                            onValuePicked: (Language language) {
                              _selectedDropdownLanguage = language;
                              // ignore: avoid_print
                              print(_selectedDropdownLanguage.name);
                              // ignore: avoid_print
                              print(_selectedDropdownLanguage.isoCode);
                            },
                          ),
                        ),
                        leading: const Icon(
                          Icons.language,
                          size: 25,
                        ),
                      )
                    ],
                  ),
                ),
                Column(children: [
                  const ListTile(
                    title: Text(
                      "Support and Feedback",
                      style: TextStyle(color: Colors.blue, fontSize: 22),
                    ),
                  ),
                  const ListTile(
                    title: Text("Terms & Privacy Policy"),
                    leading: Icon(
                      Icons.question_mark,
                      size: 25,
                    ),
                  ),
                  const ListTile(
                    title: Text("FAQ"),
                    leading: Icon(
                      Icons.chat_sharp,
                      size: 25,
                    ),
                  ),
                  const ListTile(
                    title: Text("Send Us Feedback"),
                    leading: Icon(
                      Icons.feedback,
                      size: 25,
                    ),
                  ),
                  ListTile(
                    title: InkWell(
                      child: const Text(
                        "About Us",
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutUs()),
                      ),
                    ),
                    leading: const Icon(
                      Icons.info,
                      size: 25,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 110,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Version 1.5'),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.blueGrey,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            minimumSize: const Size(110, 50),
                          ),
                          onPressed: () {
                            signOut();
                          },
                          child: const Text(
                            "Log Out",
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
