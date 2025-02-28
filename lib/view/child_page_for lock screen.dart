import 'package:dynamictechnosoft/provider/permission_checker_provider.dart';
import 'package:dynamictechnosoft/view/location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class PermissionScreen extends ConsumerWidget {
    final Uri url = Uri.parse('https://www.youtube.com');
Future<void> _launchUrl() async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
  @override

  Widget build(BuildContext context, WidgetRef ref) {
    final isCameraGranted = ref.watch(cameraPermissionProvider);
    final isGpsGranted = ref.watch(gpsPermissionProvider);
    final isBluetoothGranted = ref.watch(bluetoothProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
          
            child: ListTile(
                onTap: () {
                  ref.read(bluetoothProvider.notifier).checkBluetoothPermission();
                },
                
                tileColor: isCameraGranted ? Colors.green : Colors.red,
                title: Text("Camera Permission"),
                subtitle: Text(
                    isCameraGranted
                        ? 'Camera Permission Granted'
                        : 'Camera Permission is denied',
                    style: TextStyle(
                        color:Colors.black)),
                trailing: IconButton(
                    onPressed: () {
                      ref
                          .read(cameraPermissionProvider.notifier)
                          .checkCameraPermission();
                    },
                    icon: Icon(
                        isCameraGranted ? Icons.check_circle : Icons.cancel,
                        color: isCameraGranted ? Colors.black : Colors.amber))),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                ref.read(bluetoothProvider.notifier).checkBluetoothPermission();
              },
              tileColor: isGpsGranted ? Colors.green : Colors.red,
              title: Text("GPS Permission"),
              subtitle: Text(
                  isCameraGranted
                      ? 'GPS Permission Granted'
                      : 'GPS Permission is denied',
                  style:
                      TextStyle(color:Colors.black)),
              trailing: IconButton(
                  onPressed: () {
                    ref.read(gpsPermissionProvider.notifier).checkGpsPermission();
                  },
                  icon: Icon(isGpsGranted ? Icons.check_circle : Icons.cancel,
                      color: isGpsGranted ? Colors.black : Colors.amber)),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              // internalAddSemanticForOnTap: true,
              onTap: () {
                ref.read(bluetoothProvider.notifier).checkBluetoothPermission();
              },

              tileColor: isBluetoothGranted ? Colors.green : Colors.red,
              title: Text("Bluetooth Permission"),
              subtitle: Text(
                  isBluetoothGranted
                      ? 'Bluetooth Permission Granted'
                      : 'Bluetooth Permission is denied',
                  style: TextStyle(
                      color:Colors.black)),
              trailing: IconButton(
                onPressed: () {
                  ref
                      .read(bluetoothProvider.notifier)
                      .checkBluetoothPermission();
                },
                icon: Icon(
                    isBluetoothGranted ? Icons.check_circle : Icons.cancel,
                    color:isBluetoothGranted ?Colors.black:Colors.amber),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(cameraPermissionProvider.notifier)
                  .checkCameraPermission();
              ref.read(gpsPermissionProvider.notifier).checkGpsPermission();
              ref.read(bluetoothProvider.notifier).checkBluetoothPermission();
            },
            child: Text("Refresh Permissions"),
          ),
                   ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder:(context)=>LocationView() ));
            },
             child: Text('Google Map')),
                           ElevatedButton(onPressed: _launchUrl,
             child: Text('Youtube'))
        ],
      ),
    );
  }
}
