import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CommunityDisa extends StatefulWidget {
  const CommunityDisa({Key? key}) : super(key: key);

  @override
  _CommunityDisaState createState() => _CommunityDisaState();
}

class _CommunityDisaState extends State<CommunityDisa> {
  List<Map<String, dynamic>> posts = [];
  Map<int, int> currentIndexMap = {}; // Initialize currentIndexMap

  @override
  void initState() {
    super.initState();
    loadPostData();
  }

  void toggleLove(int postIndex) {
    setState(() {
      if (posts[postIndex]['isLoved'] == null || !posts[postIndex]['isLoved']) {
        // If not loved or null, mark as loved and increase the count
        posts[postIndex]['isLoved'] = true;
        posts[postIndex]['loveCount'] =
            (posts[postIndex]['loveCount'] ?? 0) + 1;
      } else {
        // If loved, unmark and decrease the count
        posts[postIndex]['isLoved'] = false;
        posts[postIndex]['loveCount'] =
            (posts[postIndex]['loveCount'] ?? 0) - 1;
      }
    });
  }

  List<Widget> _buildImageBubbles(int currentIndex, int totalImages) {
    List<Widget> bubbles = [];

    for (int i = 0; i < totalImages; i++) {
      bubbles.add(
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == currentIndex ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }

    return bubbles;
  }

  Future<void> loadPostData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('posts');

    if (jsonData != null) {
      final List<dynamic> dataList = json.decode(jsonData);

      final List<Map<String, dynamic>> loadedPosts = dataList
          .map((data) {
            if (data['images'] is List<dynamic>) {
              data['images'] = data['images'].cast<String>();
            }
            return Map<String, dynamic>.from(data);
          })
          .cast<Map<String, dynamic>>()
          .toList();

      setState(() {
        posts = loadedPosts;

        // Initialize currentIndex values for each CarouselSlider
        for (int i = 0; i < posts.length; i++) {
          currentIndexMap[i] = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Disa'),
        backgroundColor: Colors.blue,
      ),
      body: posts.isEmpty
          ? Center(
              child: Text(
                'No posts to display',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final images = post['images'];
                final title = post['title'];
                final description = post['description'];
                final bool isLoved = post['isLoved'] ?? false;
                final int loveCount = post['loveCount'] ?? 0;
                if (images != null &&
                    images is List<String> &&
                    images.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 200.0,
                              viewportFraction: 1.0,
                              enableInfiniteScroll: false,
                              initialPage: currentIndexMap[index] ??
                                  0, // Use a default value of 0 if currentIndexMap[index] is null
                              onPageChanged: (int imageIndex,
                                  CarouselPageChangedReason reason) {
                                setState(() {
                                  // Update the current index for the specific set of images
                                  currentIndexMap[index] = imageIndex;
                                });
                              },
                            ),
                            items: images.map((imagePath) {
                              return Image.file(File(imagePath));
                            }).toList(),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildImageBubbles(
                                currentIndexMap[index] ?? 0,
                                images
                                    .length), // Use a default value of 0 if currentIndexMap[index] is null
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: InkWell(
                                  onTap: () {
                                    toggleLove(index);
                                  },
                                  child: Icon(
                                    isLoved
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isLoved ? Colors.red : Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Text(loveCount.toString()),
                              SizedBox(width: 8.0),
                              Icon(
                                Icons.send,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          if (title != null && title.isNotEmpty)
                            Padding(
                                padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          if (description != null && description.isNotEmpty)
                            Padding(
                                padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(description),
                                )),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
    );
  }
}
