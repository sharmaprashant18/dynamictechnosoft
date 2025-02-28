

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraNotifier extends StateNotifier<bool> {
  CameraNotifier() : super(false) {
    // Future.microtask(() => checkCameraPermission());
    checkCameraPermission();
  }

  Future<void> checkCameraPermission() async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      state = true;
    } else {
      state = false;
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }
}
final cameraPermissionProvider =
    StateNotifierProvider<CameraNotifier, bool>((ref) => CameraNotifier());

// GPS Provider
class GpsNotifier extends StateNotifier<bool> {
  GpsNotifier() : super(false) {
    // Future.microtask(() => checkGpsPermission());
    checkGpsPermission();
  }

  Future<void> checkGpsPermission() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      state = true;
    } else {
      state = false;
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }
}

final gpsPermissionProvider =
    StateNotifierProvider<GpsNotifier, bool>((ref) => GpsNotifier());

// Bluetooth Provider
class BluetoothProvider extends StateNotifier<bool> {
  BluetoothProvider() : super(false) {
    // Future.microtask(() => checkBluetoothPermission());
    checkBluetoothPermission();
  }

  Future<void> checkBluetoothPermission() async {
    var status = await Permission.bluetooth.request();

    if (status.isGranted) {      state = true;
    } else {
      state = false;
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }
}

final bluetoothProvider =
    StateNotifierProvider<BluetoothProvider, bool>((ref) => BluetoothProvider());
