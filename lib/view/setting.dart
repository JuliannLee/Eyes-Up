import 'package:flutter/material.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';

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
        SizedBox(
          width: 8,
        ),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 195,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Profile",
                          style: TextStyle(color: Colors.blue, fontSize: 22),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Personal Details",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Notifications",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Change Themes",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Languages",
                          style: TextStyle(color: Colors.blue, fontSize: 22),
                        ),
                      ),
                      ListTile(
                        title: Text("Select Language"),
                        trailing: Container(
                          width: 250,
                          child: LanguagePickerDropdown(
                            initialValue: Languages.english,
                            itemBuilder: _buildDropdownItem,
                            onValuePicked: (Language language) {
                              _selectedDropdownLanguage = language;
                              print(_selectedDropdownLanguage.name);
                              print(_selectedDropdownLanguage.isoCode);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: Column(children: [
                    ListTile(
                      title: Text(
                        "Support and Feedback",
                        style: TextStyle(color: Colors.blue, fontSize: 22),
                      ),
                    ),
                    ListTile(
                      title: Text("Terms & Privacy Policy"),
                      leading: Icon(
                        Icons.question_mark,
                        size: 25,
                      ),
                    ),
                    ListTile(
                      title: Text("FAQ"),
                      leading: Icon(
                        Icons.chat_sharp,
                        size: 25,
                      ),
                    ),
                    ListTile(
                      title: Text("Send Us Feedback"),
                      leading: Icon(
                        Icons.feedback,
                        size: 25,
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 110,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Version 1.0'),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.blueGrey,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            minimumSize: Size(100, 60),
                          ),
                          onPressed: () {},
                          child: Text("Log Out")),
                    ],
                  ),
                ),
                SizedBox(
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
