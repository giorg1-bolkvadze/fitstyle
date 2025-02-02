import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        backgroundColor: Colors.green[600],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingsOption("Bildirimler", Icons.notifications),
          _buildSettingsOption("Gizlilik Politikası", Icons.lock),
          _buildSettingsOption("Hesap Ayarları", Icons.person),
          _buildSettingsOption("Çıkış Yap", Icons.exit_to_app),
        ],
      ),
    );
  }

  Widget _buildSettingsOption(String title, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.green[700]),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
