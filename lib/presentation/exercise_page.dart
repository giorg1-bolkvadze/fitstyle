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
          _buildExerciseCard("Günlük 30 Dakika Yürüyüş", "Her gün 30 dakika yürüyüş yaparak formda kalın."),
          _buildExerciseCard("Evde Antrenman", "Şınav, mekik ve squat gibi hareketleri deneyin."),
          _buildExerciseCard("Esneme Hareketleri", "Kas sağlığınızı korumak için düzenli esneme yapın."),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(String title, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}