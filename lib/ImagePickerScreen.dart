import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Define custom colors
const Color primaryColor = Color(0xFF4CAF50); // Green
const Color backgroundColor = Color(0xFFF5F5F5); // Light Grey

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an Image'),
        backgroundColor: primaryColor, // Use the primary color
      ),
      body: Container(
        color: backgroundColor, // Background color of the body
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(_image!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Use the primary color
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Take a Photo'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Use the primary color
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Pick from Gallery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
