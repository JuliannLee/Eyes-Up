import 'package:flutter/material.dart';
import 'package:p01/view/pickroles.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:p01/view/auth/addaccount.dart';

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
  final names = List.generate(3, (index) => randomAlpha(10));
  final emails = List.generate(3, (index) => '${randomAlpha(10)}@gmail.com');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 800,
              height: 680,
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
                  const Text("Choose Account",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                  const Text("To Continue to Eyes Up",style: TextStyle(fontSize: 20),),
                  Expanded(
                    child: ListView.separated(
                      itemCount: emails.length + 1,
                      separatorBuilder:
                          (BuildContext context, int index) => const Divider(
                        color: Colors.black,
                        height: 1,
                        thickness: 0.3,
                        indent: 5,
                        endIndent: 5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < emails.length) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Roles(),
                                ),
                              );
                            },
                            child: _listItem(context, index),
                          );
                        }
                        else {
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 218, 217, 217),
    );
  }

  Widget _listItem(BuildContext context, int i) {
    final iconData = allIconData[i % allIconData.length];

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isTapped = i;
        });
      },
      onExit: (_) {
        setState(() {
          isTapped = null;
        });
      },
      child: ListTile(
        leading: Icon(
          iconData,
          size: 40,
        ),
        title: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  names[i],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isTapped == i ? Colors.yellow : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(emails[i]),
          ],
        ),
      ),
    );
  }
}
