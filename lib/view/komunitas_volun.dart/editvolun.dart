import 'package:flutter/material.dart';
class EditPost extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;

  const EditPost({Key? key, this.initialTitle, this.initialDescription}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialTitle);
    descriptionController = TextEditingController(text: widget.initialDescription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 1, // Adjust the number of lines as needed
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Get the edited title and description values
                final editedTitle = titleController.text;
                final editedDescription = descriptionController.text;

                // Create a map with the edited values to pass back to the previous screen
                final editedPostData = {
                  'title': editedTitle,
                  'description': editedDescription,
                };

                // Return the edited data to the previous screen
                Navigator.pop(context, editedPostData);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}