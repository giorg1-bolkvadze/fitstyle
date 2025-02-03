import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final List<Map<String, dynamic>> exercises = [
    {
      "title": "Kas Gruplarına Göre Egzersizler",
      "description":
          "Kas gruplarına göre egzersizler yaparak vücudunuzu şekillendirin.",
      "icon": Icons.fitness_center,
      "isSelected": false,
      "points": 20,
    },
    {
      "title": "Kardiyo Egzersizleri",
      "description": "Kardiyo egzersizleri yaparak kalbinizi güçlendirin.",
      "icon": Icons.favorite,
      "isSelected": false,
      "points": 20,
    },
    {
      "title": "Yoga",
      "description": "Yoga yaparak zihninizi ve bedeninizi dinlendirin.",
      "icon": Icons.self_improvement,
      "isSelected": false,
      "points": 15,
    },
    {
      "title": "Günlük 30 Dakika Yürüyüş",
      "description": "Her gün 30 dakika yürüyüş yaparak formda kalın.",
      "icon": Icons.directions_walk,
      "isSelected": false,
      "points": 15,
    },
    {
      "title": "Evde Antrenman",
      "description": "Şınav, mekik ve squat gibi hareketleri deneyin.",
      "icon": Icons.home,
      "isSelected": false,
      "points": 15,
    },
    {
      "title": "Esneme Hareketleri",
      "description": "Kas sağlığınızı korumak için düzenli esneme yapın.",
      "icon": Icons.accessibility,
      "isSelected": false,
      "points": 15,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Egzersizler"),
        backgroundColor: Colors.green[600],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return _buildExerciseCard(
            exercise["title"],
            exercise["description"],
            exercise["icon"],
            exercise["isSelected"],
            exercise["points"],
            (bool? newValue) {
              setState(() {
                exercises[index]["isSelected"] = newValue ?? false;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildExerciseCard(
    String title,
    String description,
    IconData iconData,
    bool isSelected,
    int points,
    ValueChanged<bool?> onChanged,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(iconData, color: Colors.green, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$points Puan",
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Checkbox(
                value: isSelected,
                onChanged: onChanged,
                activeColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
