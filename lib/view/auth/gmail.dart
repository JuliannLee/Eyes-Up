import 'package:flutter/material.dart';
import 'package:p01/view/pickroles.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:p01/view/auth/addaccount.dart';
import 'package:provider/provider.dart';
import 'package:p01/providers/prov.dart';

class Gmail extends StatelessWidget {
  const Gmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GmailView(),
    );
  }
}

class GmailView extends StatefulWidget {
  const GmailView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GmailViewState createState() => _GmailViewState();
}

class _GmailViewState extends State<GmailView> {
  int? isTapped;
  final allIconData = [
    MaterialCommunityIcons.account,
  ];

  @override
  Widget build(BuildContext context) {
    final provData = Provider.of<Prov>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 750,
              height: 710,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 180,
                      height: 180,
                    ),
                  ),
                  const Text(
                    "Choose Account",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "To Continue to Eyes Up",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: provData.data.length + 1,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: Colors.black,
                        height: 1,
                        thickness: 0.3,
                        indent: 5,
                        endIndent: 5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < provData.data.length) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Roles(),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(provData.data[index]["Name"]),
                                    subtitle:
                                        Text(provData.data[index]["Email"]),
                                    leading:
                                        const Icon(MaterialCommunityIcons.account,size: 40,),
                                  ),
                                ],
                              ));
                        } else {
                          return ListTile(
                            leading: const Icon(
                              Icons.add,
                              size: 40,
                            ),
                            title: const Text(
                              "Add Another Account",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddAccount(),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const Text.rich(
                    TextSpan(
                      text:
                          'To Continue, Google will share your name, email address, and profile picture with Eyes Up. '
                          'Before using this app, review its ',
                      children: <TextSpan>[
                        TextSpan(
                          text: 'privacy policy',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            decoration: TextDecoration.underline,
                          ),
                          // Add onTap handler for privacy policy link if desired
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'terms of service',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            decoration: TextDecoration.underline,
                          ),
                          // Add onTap handler for terms of service link if desired
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 218, 217, 217),
    );
  }
}
