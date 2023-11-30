import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:p01/view/model%20data/model_data.dart';

class CommunityDisa extends StatefulWidget {
  const CommunityDisa({Key? key}) : super(key: key);

  @override
  _CommunityDisaState createState() => _CommunityDisaState();
}

class _CommunityDisaState extends State<CommunityDisa> {
  List<EventModel> posts = [];
  Map<int, int> currentIndexMap = {};

  Future<void> toggleLove(int postIndex) async {
    setState(() {
      posts[postIndex].toggleLove();
    });

    bool isLoved = posts[postIndex].is_like;
    int loveCount = posts[postIndex].loveCount;

    await updateFirestoreLoveData(posts[postIndex].id!, isLoved, loveCount);
  }

  Future<void> updateFirestoreLoveData(
      String postId, bool isLoved, int loveCount) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection('postingan').doc(postId).update({
        'is_like': isLoved,
        'love_count': loveCount,
      });
      print('Firestore love data updated successfully!');
    } catch (error) {
      print('Error updating Firestore love data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    loadPostData();
  }

  Future<void> loadPostData() async {
    try {
      await Firebase.initializeApp();
      FirebaseFirestore db = FirebaseFirestore.instance;
      var data = await db.collection('postingan').get();

      if (mounted) {
        setState(() {
          posts =
              data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
        });
      }
    } catch (e) {
      // Handle any exceptions that might occur during data retrieval
      print("Error: $e");
    }
  }

  List<Widget> _buildImageBubbles(int currentIndex, int totalImages) {
    List<Widget> bubbles = [];
    for (int i = 0; i < totalImages; i++) {
      bubbles.add(
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: 4.0,
            backgroundColor: i == currentIndex ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }
    return bubbles;
  }

  Widget _buildImageWidget(String imagePath) {
    try {
      return Image.network(
        imagePath,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          print("Error loading image: $error");
          return Image.asset(
              'assets/images/logo.png'); // Replace with the actual path to your placeholder image asset
        },
      );
    } catch (e) {
      print("Error loading image: $e");
      return Image.asset(
          'assets/images/logo.png'); // Replace with the actual path to your placeholder image asset
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Community'),
        backgroundColor: Colors.blue,
      ),
      body: posts.isEmpty
          ? const Center(
              child: Text(
                'No posts to display',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: (posts != null) ? posts.length : 0,
              itemBuilder: (context, index) {
                final images = posts[index].gambar;
                final title = posts[index].judul;
                final description = posts[index].keterangan;
                final bool isLoved = posts[index].is_like;
                final int loveCount = posts[index].loveCount;

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
                            initialPage: currentIndexMap[index] ?? 0,
                            onPageChanged: (int imageIndex,
                                CarouselPageChangedReason reason) {
                              setState(() {
                                currentIndexMap[index] = imageIndex;
                              });
                            },
                          ),
                          items: posts[index].gambar.map<Widget>((imagePath) {
                            return _buildImageWidget(imagePath);
                          }).toList(),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildImageBubbles(
                              currentIndexMap[index] ?? 0,
                              posts[index].gambar?.length ?? 0),
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
                            const SizedBox(width: 5.0),
                            Text(loveCount.toString()),
                            const SizedBox(width: 8.0),
                            const Icon(
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
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        if (description != null && description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(description),
                            ),
                          ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
