import 'package:fitstyle/presentation/web_view_page.dart';
import 'package:fitstyle/sources/local/education_centers_local_data.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EducationCenterScreen extends StatefulWidget {
  const EducationCenterScreen({super.key});

  @override
  State<EducationCenterScreen> createState() => _EducationCenterScreenState();
}

class _EducationCenterScreenState extends State<EducationCenterScreen> {
  final TextEditingController _searchController = TextEditingController();
  List educationCentersFiltered = educationCenters;

  void _filterCenters(String query) {
    setState(() {
      if (query.isEmpty) {
        educationCentersFiltered = educationCenters;
      } else {
        educationCentersFiltered = educationCenters.where((center) {
          final nameLower = center.toString().toLowerCase();
          final queryLower = query.toLowerCase();
          return nameLower.contains(queryLower);
        }).toList();
      }
    });
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
        title: const Text(
          'Halk Eğitim Merkezleri',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[600],
        elevation: 5,
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
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ).animate().fade(duration: 600.ms),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: educationCentersFiltered.length,
              itemBuilder: (context, index) {
                final educationCenter = educationCentersFiltered[index];
                return Card(
                  color: const Color.fromARGB(255, 8, 231, 19),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.map_outlined,
                          size: 30, color: Colors.green),
                    ),
                    title: Text(
                      educationCenter.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(educationCenter.address,
                            style: TextStyle(color: Colors.green.shade700)),
                        Text(educationCenter.phone,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.open_in_browser,
                          color: Colors.green),
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
                  )
                      .animate()
                      .slide(duration: 800.ms, begin: const Offset(0, 0.2)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
