import 'package:dynamictechnosoft/model/google_map_history_model.dart';
import 'package:dynamictechnosoft/view/location_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  Position? currentPosition;
  GoogleMapController? googleMapController;
  PolylinePoints polylinePoints = PolylinePoints();
  final Set<Marker> markers = {};
  final Set<Polyline> polyline = {};
  Stream<Position>? positionStream;
  List<LocationData> locationHistory = [];
  final List<LatLng> otherLocations = [
    LatLng(27.68403, 85.3333),
    LatLng(27.6808, 85.3295),
    LatLng(27.68347, 85.33333),
    LatLng(27.6804, 85.3306),
    LatLng(27.68216, 85.33234),
    LatLng(27.6815, 85.3287),
    LatLng(27.6852, 85.3341),
    LatLng(27.6799, 85.3312),
    LatLng(27.6845, 85.3309),
    LatLng(27.6802, 85.3343)
  ];
  final List<LatLng> destinationLocation = [
    LatLng(27.68403, 85.3333),
    LatLng(27.6808, 85.3295),
    LatLng(27.68347, 85.33333),
    LatLng(27.6804, 85.3306),
    LatLng(27.68216, 85.33234),
    LatLng(27.6815, 85.3287),
    LatLng(27.6852, 85.3341),
    LatLng(27.6799, 85.3312),
    LatLng(27.6845, 85.3309),
    LatLng(27.6802, 85.3343)
  ];

  @override
  void initState() {
    super.initState();
    getStreamedLocation();
    getCurrentLocation();
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

  Future<void> getStreamedLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSettings();
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      showSettings();
      return;
    }
    if (permission == LocationPermission.deniedForever) {
      showSettings();
      return;
    }
    positionStream = await Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.medium,
      distanceFilter: 0,
    ));
    positionStream!.listen((Position position) async {
       List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    String placeName = placemarks.isNotEmpty
        ? '${placemarks.first.street}, ${placemarks.first.locality}'
        : 'Unknown Location';

      setState(() {
        currentPosition = position;
        locationHistory.add(LocationData(
            positions: LatLng(
                currentPosition!.latitude,
                currentPosition!
                    .longitude), //here this positions&timestap came from the model
            timestap: DateTime.now(),
         locationName: placeName
            ));
        if (googleMapController != null) {
          googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(
            LatLng(currentPosition!.latitude, position.longitude),
            19.151926040649414,
          ));
        }
        aboutOtherlocation();
        aboutPolyline();
      });
    });
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSettings();
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      showSettings();
      return;
    }
    if (permission == LocationPermission.deniedForever) {
      showSettings();
      return;
    }
    try {
      final poition = await Geolocator.getCurrentPosition();
      setState(() {
        currentPosition = poition;
      });
      aboutOtherlocation();
      aboutPolyline();
    } catch (e) {
      throw Exception('Error fetching location:$e');
    }
    if (googleMapController != null) {
      googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(currentPosition!.latitude, currentPosition!.longitude),
          19.151926040649414));
    }
  }

  void aboutPolyline() async {
    if (currentPosition == null) return;
    // setState(() {
    //   polyline.clear();
    // this clears the polyline

    // });
    LatLng origin =
        LatLng(currentPosition!.latitude, currentPosition!.longitude);
    List<LatLng> polylineCoordinates = [];
    for (int i = 0; i < destinationLocation.length; i++) {
      LatLng destination = destinationLocation[i];
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey: 'AIzaSyAy_PypepUn9LV1iZo-lWn0nht29X2FbWc',
          request: PolylineRequest(
              origin: PointLatLng(origin.latitude, origin.longitude),
              destination:
                  PointLatLng(destination.latitude, destination.longitude),
              mode: TravelMode.driving));
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng( point.latitude, point.longitude));
        }
      }
      origin = destination;
      markers.add(Marker(
          markerId: MarkerId('PolyLinePoint$i'),
          position: destinationLocation[i],
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
    }
    setState(() {
      polyline.add(Polyline(
          polylineId: PolylineId('Polyline'),
          geodesic: true,
          color: Colors.green,
          width: 5,
          points: polylineCoordinates,
          patterns: [PatternItem.gap(3), PatternItem.dot]));
    });
  }

  void aboutOtherlocation() async {
    if (currentPosition == null) return;
    setState(() {
      markers.removeWhere(
          (marker) => !marker.markerId.value.startsWith('history'));
      for (int i = 0; i < otherLocations.length; i++) {
        markers.add(
          Marker(
              markerId: MarkerId('Person$i'),
              position: otherLocations[i],
              infoWindow: InfoWindow(
                title: 'Person${i + 1}',
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue)),
        );
      }
      markers.add(
        Marker(
            markerId: MarkerId('currentLocation'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position:
                LatLng(currentPosition!.latitude, currentPosition!.longitude),
            infoWindow: InfoWindow(title: 'Current Location')),
      );
    });
  }

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  void showSettings() {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text('Enable the location'),
          content: Text('Location is turned off. Open location'),
          actions: [
            TextButton(
                onPressed: Geolocator.openLocationSettings, child: Text('Yes'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('Google Map'),
              actions: [
                IconButton(icon: Icon(Icons.history), onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder:(context) => LocationHistoryScreen(locationHistoryScreen: locationHistory),));
                  //the locationHistoryScreen takes the list of the locationHistory that passes from the list of locationHistory and according to the getStreamedPosition
                } ), 
              ],

            ),
      extendBodyBehindAppBar: true,
      
      // drawer: Drawer(
      //   // backgroundColor: Colors.red,
      //   child: Column(
      //     children: [
      //       Card(
      //         child: DrawerHeader(
      //           child: Text('Location History', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,)),
      //         ),
      //       ),

      //       Expanded(
      //         child: ListView.builder(
      //           itemCount: locationHistory.length,
      //           itemBuilder: (context, index) {
      //             final loc = locationHistory[index];
      //             return Card(
      //               child: ListTile(
      //                 tileColor: Colors.red,
        
      //             onTap: () {
      //               Navigator.pop(context);
      //             },                            
      //                 minTileHeight: 5,

      //                 title: Row(
      //                   children: [
      //                      Icon(Icons.location_on, color: Colors.black),
      //                     Flexible(
      //                       child: Text(
      //                          loc.locationName, ),
      //                     ),
      //                   ],
      //                 ),
      //                 // subtitle: 
      //                 subtitle: Row(
      //                   children: [
      //                     Icon(Icons.timelapse,color: Colors.black,),
      //                     Text('Time: ${formatDateTime(loc.timestap)}'),
      //                   ],
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      body: currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentPosition!.latitude, currentPosition!.longitude),
                zoom: 19.151926040649414,
                bearing: 192.8334901395799,
              ),
              mapToolbarEnabled: true,
              buildingsEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
              markers: markers,
              polylines: polyline,
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: getCurrentLocation,
            child: IconButton(
                onPressed: getCurrentLocation, icon: Icon(Icons.gps_fixed)),
          ),
        ],
      ),
    );
  }
}



