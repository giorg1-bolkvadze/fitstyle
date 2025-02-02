import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _calculateBMI() async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    double height = userDoc['height'] / 100;
    double weight = userDoc['weight'];
    double bmi = weight / (height * height);
    String message;

    if (bmi < 18.5) {
      message = "Biraz kilo alabilirsin!";
    } else if (bmi < 24.9) {
      message = "İdeal kilodasın!";
    } else {
      message = "5 kilo daha verirsen harika olur!";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("BMI Sonucu"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tamam"))
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
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
        title: const Text("Profil"),
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(Icons.camera_alt, size: 40)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: const Text("BMI Hesapla"),
            ),
          ],
        ),
      ),
    );
  }
}
