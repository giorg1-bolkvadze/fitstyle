import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Egzersizler"),
        backgroundColor: Colors.green[600],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildExerciseCard(
            "Kas Gruplarına Göre Egzersizler",
            "Kas gruplarına göre egzersizler yaparak vücudunuzu şekillendirin.",
            Icons.fitness_center,
          ),
          _buildExerciseCard(
            "Kardiyo Egzersizleri",
            "Kardiyo egzersizleri yaparak kalbinizi güçlendirin.",
            Icons.favorite,
          ),
          _buildExerciseCard(
            "Yoga",
            "Yoga yaparak zihninizi ve bedeninizi dinlendirin.",
            Icons.self_improvement,
          ),
          _buildExerciseCard(
            "Günlük 30 Dakika Yürüyüş",
            "Her gün 30 dakika yürüyüş yaparak formda kalın.",
            Icons.directions_walk,
          ),
          _buildExerciseCard(
            "Evde Antrenman",
            "Şınav, mekik ve squat gibi hareketleri deneyin.",
            Icons.home,
          ),
          _buildExerciseCard(
            "Esneme Hareketleri",
            "Kas sağlığınızı korumak için düzenli esneme yapın.",
            Icons.accessibility,
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(
      String title, String description, IconData iconData) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(iconData,
            color: Colors.green, size: 30), // 📌 Dinamik ikon kullanıldı
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
