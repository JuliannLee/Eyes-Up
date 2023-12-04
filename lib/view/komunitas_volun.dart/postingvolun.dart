import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../model data/model_data.dart';
import 'package:permission_handler/permission_handler.dart';

class Posting extends StatefulWidget {
  final Function() onPostCreated;

  const Posting({Key? key, required this.onPostCreated}) : super(key: key);

  @override
  State<Posting> createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  MyAnalyticsHelper fbAnalytics = MyAnalyticsHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<File> selectedImages = [];
  final uuid = Uuid();

  Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images')
          .child(fileName);

      // Specify content type as 'image/jpeg'
      firebase_storage.SettableMetadata metadata =
          firebase_storage.SettableMetadata(contentType: 'image/jpeg');

      firebase_storage.UploadTask uploadTask =
          reference.putFile(imageFile, metadata);

      await uploadTask.whenComplete(() => print('Image uploaded'));

      String imageUrl = await reference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      // Handle error
      print('Error uploading image: $e');
      throw e; // Propagate the error to the caller
    }
  }

  Future<void> _selectImages() async {
    // Check gallery permission
    var status = await Permission.storage.status;

    if (status.isDenied || status.isRestricted) {
      // Request gallery permission
      await Permission.storage.request();

      // Check the updated permission status
      status = await Permission.storage.status;

      if (status.isDenied || status.isRestricted) {
        // Permission still not granted, handle accordingly
        return;
      }
    }

    // Gallery permission is granted, proceed with image selection
    final imagePicker = ImagePicker();
    final pickedImages = await imagePicker.pickMultiImage();

    setState(() {
      selectedImages.addAll(pickedImages.map((image) => File(image.path)));
    });
  }

  Future<void> savePostData(EventModel postModel) async {
    try {
      List<String> imageUrls = [];

      // Upload images to Firebase Storage
      for (File imageFile in selectedImages) {
        String imageUrl = await uploadImage(imageFile);
        imageUrls.add(imageUrl);
      }

      // Save post data to Cloud Firestore
      postModel.gambar =
          imageUrls; // Replace local paths with Firebase Storage URLs
      await FirebaseFirestore.instance
          .collection('postingan')
          .add(postModel.toMap());

      // Analytics event
      await fbAnalytics.testEventLog('post_created');
    } catch (e) {
      print('Error saving post: $e');
      // Handle error
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
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
                    (imageFile) => Container(
                      width: 100.0,
                      height: 100.0,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Image.file(imageFile, fit: BoxFit.cover),
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
              onPressed: () async {
                final title = titleController.text;
                final description = descriptionController.text;
                if (selectedImages.isNotEmpty && title.isNotEmpty) {
                  final postModel = EventModel(
                    gambar: selectedImages.map((image) => image.path).toList(),
                    judul: title,
                    keterangan: description,
                    is_like:
                        false, // Default value, change it according to your logic
                    loveCount: 0,
                  );

                  // Now you can save the postModel to Firebase or perform any other actions
                  await savePostData(postModel);
                  widget.onPostCreated();
                  // Close the posting screen
                  Navigator.pop(context);
                } else {
                  // Show an error dialog if the form is incomplete
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                          'Please select at least one image and provide a title.',
                        ),
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

class MyAnalyticsHelper {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // Log a custom event
  Future<void> testEventLog(String value) async {
    await analytics.logEvent(name: "${value}");
    print('Berhasil menambah postingan!');
  }
}
