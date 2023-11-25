import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../model data/model_data.dart';
class Posting extends StatefulWidget {
  const Posting({Key? key}) : super(key: key);

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
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child(fileName);

    firebase_storage.UploadTask uploadTask = reference.putFile(imageFile);

    await uploadTask.whenComplete(() => print('Image uploaded'));

    return await reference.getDownloadURL();
  }
 Future<void> _selectImages() async {
    final imagePicker = ImagePicker();
    final pickedImages = await imagePicker.pickMultiImage(); // Allow multiple image selection

    if (pickedImages != null) {
      setState(() {
        selectedImages.addAll(pickedImages.map((image) => File(image.path)));
      });
    }
  }

  Future<void> savePostData(EventModel postModel) async {
    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('postingan').add(postModel.toMap());
    // You can also handle success or error cases here
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
              onPressed: () async {
                final title = titleController.text;
                final description = descriptionController.text;
                if (selectedImages.isNotEmpty && title.isNotEmpty) {
                  final postModel = EventModel(
                    gambar: selectedImages.map((image) => image.path).toList(),
                    judul: title,
                    keterangan: description,
                    is_like: false, // Default value, change it according to your logic
                    loveCount: 0,
                  );

                  // Now you can save the postModel to Firebase or perform any other actions
                  await savePostData(postModel);

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