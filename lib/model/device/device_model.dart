import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceModel {
  String operatingSystem;
  var phoneInfo;
  String? ipAddress;
  PackageInfo packageInfo;
  String imeiNumber;
  Position currentPosition;

  DeviceModel({
    required this.operatingSystem,
    required this.phoneInfo,
    required this.ipAddress,
    required this.packageInfo,
    required this.imeiNumber,
    required this.currentPosition,
  });
}
