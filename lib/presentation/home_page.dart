import 'package:fitstyle/presentation/video_player_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FitStyle",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[600],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade600, Colors.green.shade300],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              _buildOptionCard(
                icon: Icons.restaurant_menu,
                title: "Beslenme Önerileri",
                subtitle: "Sağlıklı tarifler ve beslenme ipuçları",
                context: context,
              ),
              const SizedBox(height: 16),
              _buildOptionCard(
                icon: Icons.fitness_center,
                title: "Egzersiz Önerileri",
                subtitle: "Günlük antrenman önerileri",
                context: context,
                onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideoPlayerView())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      {required IconData icon,
      required String title,
      required String subtitle,
      required BuildContext context,
      void Function()? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      shadowColor: Colors.black45,
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green.shade100,
            child: Icon(icon, color: Colors.green.shade700),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: onTap),
    );
  }
}
