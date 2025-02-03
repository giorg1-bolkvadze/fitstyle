import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
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
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final picker = ImagePicker();
  Map<String, int> _dailyPoints = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _profileImagePath = "";
  String _name = "";
  int _age = 0;
  double _height = 0;
  double _weight = 0;

  int _totalPoints = 0;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _loadPoints();
  }

  Future<void> _loadPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _totalPoints = prefs.getInt('earnedPoints') ?? 0;

      _dailyPoints = _getLast7DaysPoints(prefs);
    });
  }

  Map<String, int> _getLast7DaysPoints(SharedPreferences prefs) {
    Map<String, int> points = {};
    DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      String date =
          DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: i)));
      points[date] = prefs.getInt(date) ?? 0;
    }
    return points;
  }

  Widget _buildPointsTable() {
    return Column(
      children: _dailyPoints.entries.map((entry) {
        return Card(
          child: ListTile(
            title: Text(
                DateFormat('EEEE, dd MMMM').format(DateTime.parse(entry.key))),
            trailing: Text("+${entry.value} puan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: entry.value > 0 ? Colors.green : Colors.red,
                )),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          barGroups: _dailyPoints.entries.map((entry) {
            return BarChartGroupData(
              x: DateTime.parse(entry.key).weekday,
              barRods: [
                BarChartRodData(
                    toY: entry.value.toDouble(), color: Colors.blue, width: 20),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text(DateFormat('E').format(DateTime.now()
                        .subtract(Duration(days: 7 - value.toInt()))));
                  }),
            ),
          ),
        ),
      ),
    );
  }

  // 📌 **Profil Fotoğrafını ve Kullanıcı Bilgilerini Lokalden Yükle**
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profileImagePath');
    String? name = prefs.getString('name');
    int? age = prefs.getInt('age');
    double? height = prefs.getDouble('height');
    double? weight = prefs.getDouble('weight');

    setState(() {
      _profileImagePath = imagePath ?? "";
      _image = imagePath != null ? File(imagePath) : null;
      _name = name ?? "Kullanıcı";
      _age = age ?? 0;
      _height = height ?? 0;
      _weight = weight ?? 0;
    });
  }

  // 📌 **Fotoğraf Seç ve Cihaza Kaydet**
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
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

  void _showMotivationMessage() {
    double bmi = _weight / ((_height / 100) * (_height / 100));
    String message;

    if (bmi < 18.5) {
      message = "Sağlıklı kilo almak için biraz daha beslenmelisin!";
    } else if (bmi < 24.9) {
      message = "Harika! İdeal kilondasin!";
    } else {
      message = "Motivasyonunu kaybetme! Daha sağlıklı bir sen için devam et!";
    }

    Get.snackbar("Motivasyon Mesajı", message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  void _editProfile() {
    TextEditingController nameController = TextEditingController(text: _name);
    TextEditingController ageController =
        TextEditingController(text: _age.toString());
    TextEditingController heightController =
        TextEditingController(text: _height.toString());
    TextEditingController weightController =
        TextEditingController(text: _weight.toString());

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Bilgileri Düzenle",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Ad Soyad")),
            TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: "Yaş")),
            TextField(
                controller: heightController,
                decoration: const InputDecoration(labelText: "Boy (cm)")),
            TextField(
                controller: weightController,
                decoration: const InputDecoration(labelText: "Kilo (kg)")),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('name', nameController.text);
                await prefs.setInt('age', int.parse(ageController.text));
                await prefs.setDouble(
                    'height', double.parse(heightController.text));
                await prefs.setDouble(
                    'weight', double.parse(weightController.text));

                setState(() {
                  _name = nameController.text;
                  _age = int.parse(ageController.text);
                  _height = double.parse(heightController.text);
                  _weight = double.parse(weightController.text);
                });

                if (Get.isBottomSheetOpen ?? false) {
                  Get.back();
                }

                _showMotivationMessage();
              },
              child: const Text(
                "Kaydet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📌 **Vücut Kitle Endeksi Hesaplama**
  void _calculateBMI() {
    double bmi = _weight / ((_height / 100) * (_height / 100));
    String message;

    if (bmi < 18.5) {
      message = "Biraz kilo alabilirsin!";
    } else if (bmi < 24.9) {
      message = "İdeal kilodasın!";
    } else {
      message = "5 kilo daha verirsen harika olur!";
    }

    Get.dialog(
      AlertDialog(
        title: const Text("Vücut Kitle Endeksin"),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Tamam"))
        ],
      ).animate().fade(duration: 500.ms),
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
        leading:
            IconButton(icon: const Icon(Icons.edit), onPressed: _editProfile),
        actionsIconTheme: const IconThemeData(),
        title: const Text("Profil"),
        backgroundColor: Colors.green[600],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Merhaba, $_name!",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Yaş: $_age | Boy: $_height cm | Kilo: $_weight kg",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _calculateBMI,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Vücut Kitle Endeksini Öğren",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ).animate().scale(duration: 500.ms),
              ),
              Text(
                "Toplam Kazanılan Puanlar: $_totalPoints",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _totalPoints > 0
                      ? Colors.green
                      : Colors.red, // 📌 RENKLİ PUAN GÖSTERİMİ
                ),
              ),
              const SizedBox(height: 20),
              Text("Son 7 Günlük Puan Kazanımı",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildPointsTable(),
              const SizedBox(height: 20),
              Text("Haftalık Puan Grafiği",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildChart(),
            ],
          ),
        ),
      ),
    );
  }
}
