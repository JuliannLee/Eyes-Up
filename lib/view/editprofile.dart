import 'package:flutter/material.dart';
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
            child: SizedBox(
              width: double.infinity,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "First Name",
                      hintText: "John"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Last Name",
                      hintText: "Doe"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Email",
                      hintText: "eyesup@gmail.com"),
                ),
                const SizedBox(
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
      ),
    );
  }
}
