import 'package:fitstyle/presentation/hospitals/hospitals_local.dart';
import 'package:fitstyle/presentation/web_view_page.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyHospitals extends StatefulWidget {
  const NearbyHospitals({super.key});

  @override
  State<NearbyHospitals> createState() => _NearbyHospitalsScreenState();
}

class _NearbyHospitalsScreenState extends State<NearbyHospitals> {
  final TextEditingController _searchController = TextEditingController();
  List hospitalsFiltered = hospitals; // Yeni hastane listesi

  void _filterHospitals(String query) {
    setState(() {
      if (query.isEmpty) {
        hospitalsFiltered = hospitals;
      } else {
        hospitalsFiltered = hospitals.where((hospital) {
          final nameLower = hospital.name.toLowerCase();
          final queryLower = query.toLowerCase();
          return nameLower.contains(queryLower);
        }).toList();
      }
    });
  }

  Future<void> _openMap(String query) async {
    final googleMapsUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Google Maps açılamıyor!';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Yakındaki Hastaneler',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterHospitals,
              decoration: InputDecoration(
                hintText: 'Hastane Ara...',
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: hospitalsFiltered.length,
            itemBuilder: (context, index) {
              final hospital = hospitalsFiltered[index];
              return Card(
                color: Colors.green, // Hastaneler için farklı bir renk
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  leading: GestureDetector(
                      onTap: () {
                        _openMap(hospital.name);
                      },
                      child: const Icon(Icons.local_hospital,
                          size: 30, color: Colors.red)),
                  title: Text(hospital.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hospital.address),
                      Text(hospital.phone),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.link),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewPage(
                                url: hospital.website,
                                name: hospital.name,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
