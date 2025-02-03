import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<Map<String, dynamic>> _tasks = [
    {"title": "20 Şınav Çek", "points": 10},
    {"title": "30 Mekik Çek", "points": 15},
    {"title": "1 Km Koş", "points": 20},
    {"title": "10 Dakika İp Atlama", "points": 15},
    {"title": "15 Dakika Yoga", "points": 10},
    {"title": "40 Squat Yap", "points": 20},
    {"title": "20 Burpee Yap", "points": 25},
    {"title": "10 Dakika Plank", "points": 30},
    {"title": "5 Km Bisiklet Sür", "points": 25},
    {"title": "30 Dakika Koş", "points": 35},
    {"title": "50 Jumping Jack Yap", "points": 15},
    {"title": "3 Km Tempolu Yürüyüş", "points": 15},
    {"title": "30 Dakika Dans Et", "points": 20},
    {"title": "40 Lunge Yap", "points": 20},
    {"title": "15 Dakika Meditasyon", "points": 10},
    {"title": "1000 Adım Yürü", "points": 10},
    {"title": "5 Dakika Soğuma Hareketleri", "points": 5},
    {"title": "30 Dakika Yüzme", "points": 30},
    {"title": "10 Dakika Esneme", "points": 10},
    {"title": "2 Dakika Duvar Oturuşu", "points": 15},
    {"title": "30 İleri Seviye Şınav", "points": 30},
    {"title": "30 Dakika Doğa Yürüyüşü", "points": 20},
    {"title": "50 Kettle Bell Swing", "points": 25},
    {"title": "20 Dakika Kardiyo", "points": 25},
    {"title": "15 Dakika Ağırlık Antrenmanı", "points": 30},
    {"title": "20 Dağ Tırmanışı Hareketi", "points": 15},
    {"title": "20 Dakika HIIT Antrenmanı", "points": 35},
    {"title": "10 Dakika Kürek Çekme", "points": 20},
    {"title": "3 Dakika Superman Hareketi", "points": 10},
    {"title": "40 Crunch Yap", "points": 15},
    {"title": "15 Dakika Koşu Bandı", "points": 25},
    {"title": "1 Dakika Tek Ayak Üzerinde Dur", "points": 10},
    {"title": "20 Dakika Merdiven Çık", "points": 30},
    {"title": "1 Dakika Şınav Pozisyonu Bekle", "points": 20},
    {"title": "10 Dakika Kardiyo Bisiklet", "points": 15},
    {"title": "50 Medicine Ball Slam", "points": 25},
    {"title": "50 Bacak Kaldırma", "points": 20},
    {"title": "20 Arka Lunge Yap", "points": 15},
    {"title": "20 Dakika Step Aerobik", "points": 20},
    {"title": "50 Deadlift Yap", "points": 30},
    {"title": "40 Reverse Crunch", "points": 15},
    {"title": "20 Dakika Tempolu Dans", "points": 25},
    {"title": "10 Dakika Bosu Topu Antrenmanı", "points": 15},
    {"title": "20 Dakika Kettlebell Egzersizi", "points": 30},
    {"title": "50 Direnç Bandı Çekişi", "points": 20},
    {"title": "30 Dakika Evde Antrenman", "points": 35},
    {"title": "5 Dakika Soğuma Hareketleri", "points": 10},
    {"title": "1 Dakika Tekrar Süpermen Hareketi", "points": 15},
    {"title": "3 Dakika Kalas (Plank)", "points": 20},
    {"title": "40 Jack Knife Mekik", "points": 20},
    {"title": "5 Dakika Nefes Egzersizleri", "points": 10},
  ];

  int _earnedPoints = 0;

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  Future<void> _loadPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _earnedPoints = prefs.getInt('earnedPoints') ?? 0;
    });
  }

  Future<void> _completeTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int taskPoints = _tasks[index]['points'];

    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int todayPoints = prefs.getInt(today) ?? 0;
    todayPoints += taskPoints;

    setState(() {
      _earnedPoints += taskPoints;
      _tasks.removeAt(index);
    });

    await prefs.setInt('earnedPoints', _earnedPoints);
    await prefs.setInt(today, todayPoints);

    Get.snackbar(
      "Görev Tamamlandı 🎉",
      "$taskPoints puan kazandın!",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Egzersiz Sayfası")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Kazanılan Puan: $_earnedPoints",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green,
                  child: ListTile(
                    title: Text(_tasks[index]['title']),
                    subtitle: Text("${_tasks[index]['points']} puan"),
                    trailing: Checkbox(
                      value: false,
                      onChanged: (bool? value) {
                        _completeTask(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
