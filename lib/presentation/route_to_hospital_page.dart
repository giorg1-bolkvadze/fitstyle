import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class RouteToHospitalPage extends StatefulWidget {
  final dynamic hospital;
  
  RouteToHospitalPage(this.hospital);

  @override
  _RouteToHospitalPageState createState() => _RouteToHospitalPageState();
}

class _RouteToHospitalPageState extends State<RouteToHospitalPage> {
  late GoogleMapController mapController;
  LatLng? _currentLocation;
  
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentLocation == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Rota Hesaplanıyor...")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Hastane Rotası")),
      body: GoogleMap(
        onMapCreated: (controller) => mapController = controller,
        initialCameraPosition: CameraPosition(target: _currentLocation!, zoom: 14),
        markers: {
          Marker(markerId: MarkerId("Me"), position: _currentLocation!),
          Marker(markerId: MarkerId(widget.hospital['name']), position: LatLng(widget.hospital['latitude'], widget.hospital['longitude']), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed))
        },
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            color: Colors.blue,
            width: 5,
            points: [_currentLocation!, LatLng(widget.hospital['latitude'], widget.hospital['longitude'])],
          )
        },
      ),
    );
  }
}