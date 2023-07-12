import 'package:flutter/material.dart';
<<<<<<< HEAD

// ignore: camel_case_types, use_key_in_widget_constructors
class editprofile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Styling Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
=======
import 'package:p01/utils/global.colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Edit Profile'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(45),
            child: Container(
              width: double.infinity,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "First Name",
                      hintText: "John"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Last Name",
                      hintText: "Doe"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Email",
                      hintText: "eyesup@gmail.com"),
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.blueGrey,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      minimumSize: const Size(110, 50),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Update Profile",
                      style: TextStyle(fontSize: 18),
                    )),
              ]),
            ),
          ),
        ),
>>>>>>> b069e44fd8dddbd0b9da220a4a7e1c89a20a82c1
      ),
    );
  }
}
<<<<<<< HEAD

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),
      ],
    );
  }
}
=======
>>>>>>> b069e44fd8dddbd0b9da220a4a7e1c89a20a82c1
