import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String dropdownValue = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          title: Text(
                            "Primary Language",
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: DropdownButton<String>(
                              value: dropdownValue,
                              items: <String>[
                                'English',
                                'Bahasa Indonesia'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              })),
                    ],
                  ),
                ),
                Container(
                  height: 300,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
