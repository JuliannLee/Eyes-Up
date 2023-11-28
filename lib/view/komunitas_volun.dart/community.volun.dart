import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model data/model_data.dart';
import 'postingvolun.dart';
import 'editvolun.dart';
class CommunityVolu extends StatefulWidget {
  const CommunityVolu({Key? key}) : super(key: key);

  @override
  _CommunityVoluState createState() => _CommunityVoluState();
}

class _CommunityVoluState extends State<CommunityVolu> {
  List<EventModel> posts = [];
  Map<int, int> currentIndexMap = {}; // Add this line
  @override
  void initState() {
    super.initState();
    loadPostData();
  }
  Future<void> toggleLove(int postIndex) async {
    setState(() {
      posts[postIndex].toggleLove();
    });

    bool isLoved = posts[postIndex].is_like;
    int loveCount = posts[postIndex].loveCount;

    await updateFirestoreLoveData(posts[postIndex].id!, isLoved, loveCount);
  }
  Future<void> updateFirestoreLoveData(String postId, bool isLoved, int loveCount) async {
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

  Future<void> loadPostData() async {
    try {
      await Firebase.initializeApp();
      FirebaseFirestore db = FirebaseFirestore.instance;
      var data = await db.collection('postingan').get();

      if (mounted) {
        setState(() {
          posts = data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
        });
      }
    } catch (e) {
      // Handle any exceptions that might occur during data retrieval
      print("Error: $e");
    }
  }


  Future<void> editPost(int postIndex) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPost(
          initialTitle: posts[postIndex].judul,
          initialDescription: posts[postIndex].keterangan,
        ),
      ),
    );

    // Check if the result is not null and contains edited data
    if (result != null) {
      // Update the post data in your data structure
      posts[postIndex].judul = result['title'];
      posts[postIndex].keterangan = result['description'];

      // Retrieve updated values from the result
      String updatedTitle = result['title'];
      String updatedDescription = result['description'];
      String? postId = posts[postIndex].id; // Assuming postId is a field in your EventModel

      try {
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection('postingan').doc(postId).update({
          'Judul': updatedTitle,
          'Keterangan': updatedDescription,
        });
        print('Firestore data updated successfully!');
        loadPostData();
      } catch (error) {
        print('Error updating Firestore data: $error');
        // Handle the error as needed
      }
    }
  }

  Future<void> deletePost(int postIndex) async {
    // Show a confirmation dialog
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        FirebaseFirestore db = FirebaseFirestore.instance;
        // Assuming 'postingan' is your collection
        await db.collection('postingan').doc(posts[postIndex].id).delete();

        // Update the UI by removing the post from the list
        setState(() {
          posts.removeAt(postIndex);
        });
      } catch (e) {
        print('Error deleting post: $e');
        // Handle error if needed
      }
    }
  }
  Widget _buildImageWidget(String imagePath) {
    try {
      return Image.network(
        imagePath,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          print("Error loading image: $error");
          return Image.asset('assets/images/logo.png'); // Replace with the actual path to your placeholder image asset
        },
      );
    } catch (e) {
      print("Error loading image: $e");
      return Image.asset('assets/images/logo.png'); // Replace with the actual path to your placeholder image asset
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

  @override
  void dispose() {
    // Dispose of any resources here
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Community'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () async {
               await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Posting(
                    onPostCreated: () async{
                      // Refresh data after coming back from the Posting screen
                      await loadPostData();
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
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
                        Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                editPost(index);
                              } else if (value == 'delete') {
                                deletePost(index);
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ];
                            },
                          ),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            viewportFraction: 1.0,
                            enableInfiniteScroll: false,
                            initialPage: currentIndexMap[index] ?? 0,
                            onPageChanged: (int imageIndex, CarouselPageChangedReason reason) {
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
                            currentIndexMap[index] ?? 0, posts[index].gambar?.length ?? 0),
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
