import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewPage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String name;

  const MapViewPage({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('education_center'),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: name),
          ),
        },
      ),
    );
  }
}