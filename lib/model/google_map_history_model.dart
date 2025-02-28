import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationData{
  final LatLng positions;
  final DateTime timestap;
  final String locationName;
  LocationData({required this.positions,required this.timestap,required this.locationName });
}