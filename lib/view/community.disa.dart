// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:p01/utils/global.colors.dart';

class CommunityDisa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColors.mainColor,
          title: Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Community'),
          ),
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          clipBehavior: Clip.antiAlias,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/thumb1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              height: 45,
                              color: const Color.fromARGB(161, 217, 217, 217),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  'Acara Volunteer di Kabupaten Deli Serdang',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            )
                          ],
                        )),
                    ListTile(
                      leading: SizedBox(
                        width: 100,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("25k"),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.share),
                          ],
                        ),
                      ),
                      trailing: SizedBox(
                          width: 155,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("posted 2 hours ago"),
                              Icon(Icons.access_time)
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          clipBehavior: Clip.antiAlias,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/thumb2.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              height: 45,
                              color: const Color.fromARGB(161, 217, 217, 217),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  'Acara Volunteer di Kabupaten Deli Serdang',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            )
                          ],
                        )),
                    ListTile(
                      leading: SizedBox(
                        width: 100,
                        child: Row(
                          children: const [
                            Icon(Icons.favorite),
                            SizedBox(
                              width: 5,
                            ),
                            Text("19k"),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.share),
                          ],
                        ),
                      ),
                      trailing: SizedBox(
                          width: 155,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("posted 1 day ago"),
                              Icon(Icons.access_time)
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          clipBehavior: Clip.antiAlias,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/thumb3.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              height: 45,
                              color: const Color.fromARGB(161, 217, 217, 217),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  'Acara Amal di Dallas, Amerika',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            )
                          ],
                        )),
                    ListTile(
                      leading: SizedBox(
                        width: 100,
                        child: Row(
                          children: const [
                            Icon(Icons.favorite),
                            SizedBox(
                              width: 5,
                            ),
                            Text("18k"),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.share),
                          ],
                        ),
                      ),
                      trailing: SizedBox(
                          width: 155,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("posted 1 day ago"),
                              Icon(Icons.access_time)
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ))));
  }
}
