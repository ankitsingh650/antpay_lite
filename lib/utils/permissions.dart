import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static final Permissions _instance = Permissions._internal();

  factory Permissions() => _instance;

  Permissions._internal();

  Future<bool> checkAndRequestPermissions() async {
    var status = await Permission.phone.status;
    if (status.isGranted) {
      return true;
    } else {
      var result = await Permission.phone.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> handleLocationPermissions() async{

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of().showSnackBar(const SnackBar(
      //     content: Text('Location services are disabled. Please enable the services')));
      print('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        print('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      print('Location permissions are permanently denied, we cannot request permissions.');

      return false;
    }
    return true;

  }
}