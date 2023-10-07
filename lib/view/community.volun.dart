// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CommunityVolu extends StatefulWidget {
  const CommunityVolu({Key? key}) : super(key: key);

  @override
  _CommunityVoluState createState() => _CommunityVoluState();
}

class _CommunityVoluState extends State<CommunityVolu> {
  List<Map<String, dynamic>> posts = [];
  Map<int, int> currentIndexMap = {};

  void toggleLove(int postIndex) {
    setState(() {
      if (posts[postIndex]['isLoved'] == null || !posts[postIndex]['isLoved']) {
        // If not loved or null, mark as loved and increase the count
        posts[postIndex]['isLoved'] = true;
        posts[postIndex]['loveCount'] = (posts[postIndex]['loveCount'] ?? 0) + 1;
      } else {
        // If loved, unmark and decrease the count
        posts[postIndex]['isLoved'] = false;
        posts[postIndex]['loveCount'] = (posts[postIndex]['loveCount'] ?? 0) - 1;
      }
    });
    savePostData(); // Save the updated posts list
  }

  @override
void initState() {
  super.initState();
  loadPostData();
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  // Reload post data when the screen is resumed (e.g., when returning from Posting)
  loadPostData();
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


  Future<void> savePostData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> dataToSave = posts.map((post) {
      if (post['image'] != null && post['image'] is File) {
        post['image'] = (post['image'] as File).path;
      }
      return post;
    }).toList();
    final jsonData = json.encode(dataToSave);
    await prefs.setString('posts', jsonData);
  }

  List<Widget> _buildImageBubbles(int currentIndex, int totalImages) {
  List<Widget> bubbles = [];

  for (int i = 0; i < totalImages; i++) {
    bubbles.add(
      Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: i == currentIndex ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }

  return bubbles;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        backgroundColor: Colors.blue,
         actions: [
          IconButton(
            onPressed: () async {
              final Map<String, dynamic>? returnedPostData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Posting(),
                ),
              );

              if (returnedPostData != null) {
                setState(() {
                  posts.add(returnedPostData);
                });
                savePostData(); // Save the updated posts list
                loadPostData(); // Refresh the data
              }
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
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            final images = post['images'];
            final title = post['title'];
            final description = post['description'];
            final bool isLoved = post['isLoved'] ?? false;
            final int loveCount = post['loveCount'] ?? 0;
            if (images != null && images is List<String> && images.isNotEmpty) {
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
                          initialPage: currentIndexMap[index] ?? 0, // Use a default value of 0 if currentIndexMap[index] is null
                          onPageChanged: (int imageIndex, CarouselPageChangedReason reason) {
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
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildImageBubbles(currentIndexMap[index] ?? 0, images.length), // Use a default value of 0 if currentIndexMap[index] is null
                      ),
                      Row(
                        children: [
                          Padding(padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),child:InkWell(
                            onTap: () {
                              toggleLove(index); 
                            },
                            child: Icon(
                              isLoved ? Icons.favorite : Icons.favorite_border, 
                              color: isLoved ? Colors.red : Colors.grey, 
                            ),
                          ),),
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
                          child: Align(alignment: Alignment.centerLeft,child:Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),)
                        ),
                      if (description != null && description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),
                          child: Align(alignment: Alignment.centerLeft,child:Text(description),)
                        ),
                        const SizedBox(height: 16.0),
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


class Posting extends StatefulWidget {
  const Posting({Key? key}) : super(key: key);

  @override
  State<Posting> createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<File> selectedImages = [];

  Future<void> _selectImages() async {
    final imagePicker = ImagePicker();
    final pickedImages = await imagePicker.pickMultiImage();

    if (pickedImages != null) {
      setState(() {
        selectedImages.addAll(pickedImages.map((image) => File(image.path)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Post'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
  children: <Widget>[
    Row(
      children: selectedImages
          .map(
            (image) => Container(
              width: 100.0,
              height: 100.0,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Image.file(image, fit: BoxFit.cover),
            ),
          )
          .toList(),
          ),
          InkWell(
            onTap: _selectImages,
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: const Icon(Icons.add_a_photo, size: 50.0),
            ),
          ),
          const SizedBox(height: 16.0),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 1,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;
                if (selectedImages.isNotEmpty && title.isNotEmpty) {
                  final postMap = {
                    'images': selectedImages.map((image) => image.path).toList(),
                    'title': title,
                    'description': description,
                  };
                  Navigator.pop(context, postMap);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please select at least one image and provide a title.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
