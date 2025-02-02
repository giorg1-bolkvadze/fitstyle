import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _profileImagePath = "";
  String _username = "";
  int _age = 0;
  double _height = 0.0;
  double _weight = 0.0;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // 📌 **Profil Verilerini Lokalden Yükle**
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath = prefs.getString('profileImagePath') ?? "";
      _username = prefs.getString('username') ?? "Kullanıcı";
      _age = prefs.getInt('age') ?? 0;
      _height = prefs.getDouble('height') ?? 0.0;
      _weight = prefs.getDouble('weight') ?? 0.0;
    });
  }

  // 📌 **Fotoğraf Seç ve Cihaza Kaydet**
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);

      // **Cihazdaki özel klasöre kaydet**
      Directory appDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDir.path}/profile_picture.jpg';
      await file.copy(filePath);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImagePath', filePath);

      setState(() {
        _profileImagePath = filePath;
        _image = File(filePath);
      });

      Get.snackbar("Başarılı", "Profil fotoğrafı güncellendi!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // 📌 **BMI Hesapla ve Mesaj Göster**
  void _calculateBMI() {
    if (_height == 0 || _weight == 0) return;

    double bmi = _weight / ((_height / 100) * (_height / 100));
    String message;

    if (bmi < 18.5) {
      message =
          "Biraz kilo alabilirsin, sağlıklı atıştırmalıkları deneyebilirsin!";
    } else if (bmi < 24.9) {
      message = "Mükemmel formdasın! Böyle devam et!";
    } else if (bmi < 29.9) {
      message = "Hafif bir kilo yönetimiyle harika hissedebilirsin!";
    } else {
      message = "Önemli olan sağlıklı hissetmek! Günlük hareket etmeyi unutma!";
    }

    Get.dialog(
      AlertDialog(
        title: const Text("Vücut Kitle Endeksin!"),
        content: Text(message, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Tamam"),
          )
        ],
      ).animate().scale(duration: 500.ms),
    );
  }

  // 📌 **Çıkış Yap**
  void _logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: Colors.green[600],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImagePath.isNotEmpty
                        ? FileImage(File(_profileImagePath))
                        : null,
                    child: _profileImagePath.isEmpty
                        ? const Icon(Icons.camera_alt, size: 40)
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Merhaba, $_username!",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Yaş: $_age | Boy: $_height cm | Kilo: $_weight kg",
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Vücut Kitle Endeksini Öğren"),
            ).animate().fade(duration: 500.ms),
          ],
        ),
      ),
    );
  }
}
