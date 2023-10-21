import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';


class CommunityVolu extends StatefulWidget {
  const CommunityVolu({Key? key}) : super(key: key);

  @override
  _CommunityVoluState createState() => _CommunityVoluState();
}

class _CommunityVoluState extends State<CommunityVolu> {
  List<Map<String, dynamic>> posts = [];
  List<Map<String, dynamic>> postsDataList = [];
  Map<int, int> currentIndexMap = {};

// Future<void> updatePostData(Map<String, dynamic> updatedData) async {
//   final response = await http.put(
//     Uri.parse('http://192.168.0.100:8000/data.json/${updatedData['id']}'), // Use the post's ID in the URL
//     body: json.encode(updatedData),
//     headers: {'Content-Type': 'application/json'},
//   );

//   if (response.statusCode == 200) {
//     // Data updated successfully
//   } else {
//     // Handle the error or show an error message
//   }
// }

// void toggleLove(int postIndex) {
//   setState(() {
//     final postingan = postsDataList[postIndex];
//     if (postingan['isLoved'] == null || !postingan['isLoved']) {
//       // If not loved or null, mark as loved and increase the count
//       postingan['isLoved'] = true;
//       postingan['loveCount'] = (postingan['loveCount'] ?? 0) + 1;
//     } else {
//       // If loved, unmark and decrease the count
//       postingan['isLoved'] = false;
//       postingan['loveCount'] = (postingan['loveCount'] ?? 0) - 1;
//     }

//     // Call the function to update the data on the server
//     updatePostData(postingan);
//   });
// }


  @override
  void initState() {
    super.initState();
    loadPostData();
  }

  Future<void> loadPostData() async {
    final response = await http.get(Uri.parse('http://192.168.0.100:8000/data.json'));
    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body);
      setState(() {
      postsDataList.clear();
        for (var data in dataList) {
      for (var datas in data) {
        postsDataList.add(datas);
      }
    }
        for (int i = 0; i < dataList.length; i++) {
          currentIndexMap[i] = 0;
        }
      });
    } else {
      print("HTTP request failed with status code: ${response.statusCode}");
      // Handle the error or show an error message
    }
  }



  Future<void> savePostData() async {
  final List<Map<String, dynamic>> dataToSave = posts.map((post) {
    if (post['image'] != null && post['image'] is File) {
      post['image'] = (post['image'] as File).path;
    }
    return post;
  }).toList();
  final jsonData = json.encode(dataToSave);
  final response = await http.post(
    Uri.parse('http://192.168.0.100:8000/data.json'),
    body: jsonData,
    headers: {'Content-Type': 'application/json'},
  );
  posts.clear();
  if (response.statusCode == 200) {
    // Data saved successfully
  } else {
    // Handle the error or show an error message
  }
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
      body: postsDataList.isEmpty
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
              itemCount: postsDataList.length,
              itemBuilder: (context, index) {
                final postingan = postsDataList[index];
                final images = postingan['images'];
                final title = postingan['title'];
                final description = postingan['description'];
                final bool isLoved = postingan['isLoved'] ?? false;
                final int loveCount = postingan['loveCount'] ?? 0;
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
                                  // editPost(index);
                                } else if (value == 'delete') {
                                  // deletePost(index);
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
                              initialPage: currentIndexMap[index] ?? 0, // Use a default value of 0 if currentIndexMap[index] is null
                              onPageChanged: (int imageIndex, CarouselPageChangedReason reason) {
                                setState(() {
                                  // Update the current index for the specific set of images
                                  currentIndexMap[index] = imageIndex;
                                });
                              },
                            ),
                            items: images.map<Widget>((imagePath) {
                              return Image.file(File(imagePath));
                            }).toList(),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildImageBubbles(currentIndexMap[index] ?? 0, images.length),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: InkWell(
                                  onTap: () {
                                    // toggleLove(index);
                                  },
                                  child: Icon(
                                    isLoved ? Icons.favorite : Icons.favorite_border,
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

class Posting extends StatefulWidget {
  const Posting({Key? key}) : super(key: key);

  @override
  State<Posting> createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<File> selectedImages = [];
  final uuid = Uuid();

  Future<void> _selectImages() async {
    final imagePicker = ImagePicker();
    final pickedImages = await imagePicker.pickMultiImage();

    setState(() {
      selectedImages.addAll(pickedImages.map((image) => File(image.path)));
    });
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
                    'id': uuid.v4(), // Generate a unique identifier
                    'images': selectedImages.map((image) => image.path).toList(),
                    'title': title,
                    'description': description,
                    'isLoved': false,
                    'loveCount': 0,
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
