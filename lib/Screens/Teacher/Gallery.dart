import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:image_picker/image_picker.dart';
  import 'package:intl/intl.dart';

import '../../widgets/app_large_text.dart'; // Import intl for date formatting

  class Gallery extends StatefulWidget {
    final Function(int) onStudentTap;

    const Gallery({Key? key, required this.onStudentTap}) : super(key: key);

  @override
  _Gallery createState() => _Gallery();
  }

  class _Gallery extends State<Gallery> {
  // Changed to hold both the image file and the upload timestamp
  List<Map<String, dynamic>> _images = [];

  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
  setState(() {
  _images.add({
  'file': File(pickedFile.path), // Store the image file
  'timestamp': DateTime.now(), // Store the current timestamp
  });
  });
  }
  }

  // Function to pick image from camera
  Future<void> _pickImageFromCamera() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
  setState(() {
  _images.add({
  'file': File(pickedFile.path), // Store the image file
  'timestamp': DateTime.now(), // Store the current timestamp
  });
  });
  }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  body: Column(

  children: <Widget>[
    _topNavigationBar(),
    AppLargeText(text: "Gallery"),
  Expanded(
  child: GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 3, // Adjust the number of grid columns here
  ),
  itemCount: _images.length,
  itemBuilder: (BuildContext context, int index) {
  // Accessing file and timestamp separately
  File imageFile = _images[index]['file'];
  DateTime timestamp = _images[index]['timestamp'];
  return GridTile(
  child: Image.file(imageFile),
  footer: Container(
  padding: const EdgeInsets.all(4.0),
  color: Colors.black54,
  child: Text(
  DateFormat('yyyy-MM-dd – kk:mm').format(timestamp),
  style: const TextStyle(color: Colors.white, fontSize: 10),
  textAlign: TextAlign.center,
  ),
  ),
  );
  },
  ),
  ),
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
  IconButton(
  icon: const Icon(Icons.photo_library),
  onPressed: _pickImageFromGallery,
  ),
  IconButton(
  icon: const Icon(Icons.camera_alt),
  onPressed: _pickImageFromCamera,
  ),
  ],
  ),
  ],
  ),
  );
  }
  }
  class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;

  const ImageDetailScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: const Text('Gallery Details'),
  ),
  body: Center(
  child: Image.asset(imageUrl),
  ),
  );
  }
  }

_topNavigationBar() {
  return Container(
      padding: const EdgeInsets.only(top: 50, left: 20),
      child: Row(
        children: [
          Icon(Icons.menu, size: 30, color: Colors.black54),
          Expanded(child: Container()),
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.5),
            ),
          )
        ],
      ));
}