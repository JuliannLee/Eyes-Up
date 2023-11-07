import 'package:flutter/material.dart';
import 'package:p01/utils/global.colors.dart';
import 'package:provider/provider.dart';
import '../providers/prov.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize text field controllers with the current values from UserProvider
    _firstNameController.text = Provider.of<Prov>(context, listen: false).userFirstName ?? "";
    _lastNameController.text = Provider.of<Prov>(context, listen: false).userLastName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = Provider.of<Prov>(context).userEmail;

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "First Name",
                    ),
                    controller: _firstNameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Last Name",
                    ),
                    controller: _lastNameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Email",
                      hintText: "YourEyes@gmail.com",
                    ),
                    initialValue: userEmail ?? "Email not available",
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.blueGrey,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: const Size(110, 50),
                    ),
                    onPressed: () {
                      // Update UserProvider with the new first name and last name
                      Provider.of<Prov>(context, listen: false).setUserFirstName(_firstNameController.text);
                      Provider.of<Prov>(context, listen: false).setUserLastName(_lastNameController.text);

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Update Profile",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
