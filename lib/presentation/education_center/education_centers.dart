import 'package:fitstyle/presentation/web_view_page.dart';
import 'package:fitstyle/sources/local/education_centers_local_data.dart.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class EducationCenters extends StatefulWidget {
  const EducationCenters({super.key});

  @override
  State<EducationCenters> createState() => _EducationCenterScreenState();
}

class _EducationCenterScreenState extends State<EducationCenters> {
  final TextEditingController _searchController = TextEditingController();
  List educationCentersFiltered = educationCenters;

  void _filterCenters(String query) {
    setState(() {
      if (query.isEmpty) {
        educationCentersFiltered = educationCenters;
      } else {
        educationCentersFiltered = educationCenters.where((center) {
          final nameLower = center.name.toLowerCase();
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
        title: Text(
          'Halk Eğitim Merkezleri',
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.values[1]),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCenters,
              decoration: InputDecoration(
                hintText: 'Merkez Ara...',
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: educationCentersFiltered.length,
            itemBuilder: (context, index) {
              final educationCenter = educationCentersFiltered[index];
              return Card(
                color: Colors.tealAccent.shade100,
                margin: EdgeInsets.all(5),
                child: ListTile(
                  leading: GestureDetector(
                      onTap: () {
                        _openMap(educationCenter.name);
                      },
                      child: Icon(Icons.map_outlined, size: 30)),
                  title: Text(educationCenter.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(educationCenter.address),
                      Text(educationCenter.phone),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.link),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewPage(
                                url: educationCenter.website,
                                name: educationCenter.name,
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
