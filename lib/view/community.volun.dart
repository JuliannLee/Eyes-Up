import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityVolu extends StatefulWidget {
  const CommunityVolu({Key? key}) : super(key: key);

  @override
  _CommunityVoluState createState() => _CommunityVoluState();
}

class _CommunityVoluState extends State<CommunityVolu> {
  List<Map<String, dynamic>> posts = [];

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
            if (data['image'] is String) {
              data['image'] = File(data['image']);
            }
            return Map<String, dynamic>.from(data);
          })
          .cast<Map<String, dynamic>>()
          .toList();

      setState(() {
        posts = loadedPosts;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
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
                final image = post['image'];
                final title = post['title'];
                final description = post['description'];

                if (image != null && image is File) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          Image.file(image),
                          if (title != null && title.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if (description != null && description.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(description),
                            ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Map<String, dynamic>? returnedPostData = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Posting(),
            ),
          );

          if (returnedPostData != null) {
            setState(() {
              posts.add(returnedPostData);
            });
            savePostData(); // Save the updated posts list
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
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
  File? selectedImage; // Store the image path as a String

  Future<void> _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path); // Store the image as a File
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _selectImage,
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: selectedImage != null
                    ? Image.file(selectedImage!, fit: BoxFit.cover)
                    : Icon(Icons.add_a_photo, size: 50.0),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 2,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;

                final postMap = {
                  'image': selectedImage, // Use the stored image as a File
                  'title': title,
                  'description': description,
                };

                Navigator.pop(context, postMap); // Pass postMap back to the previous screen
              },
              child: Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}

