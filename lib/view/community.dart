// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: 100,
                    child: Row(
                      children: [
                        Icon(Icons.favorite),
                        SizedBox(
                          width: 5,
                        ),
                        Text("1.9k"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.share),
                      ],
                    ),
                  ),
                  trailing: Container(
                      width: 155,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("posted 2 hours ago"),
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
