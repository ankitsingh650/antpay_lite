
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_information/device_information.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart' show PlatformException, Platform;
import 'package:permission_handler/permission_handler.dart';

import '../../utils/permissions.dart';
import 'device_model.dart';

class DeviceInfoSingleton {
  static final DeviceInfoSingleton _instance = DeviceInfoSingleton._internal();

  factory DeviceInfoSingleton() => _instance;

  DeviceInfoSingleton._internal();

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  late AndroidDeviceInfo _androidDeviceInfo;
  late IosDeviceInfo _iosDeviceInfo;
  late PackageInfo _packageInfo;

  Future<void> initialize() async {
    await _getPhoneInfo();
    await _getPackageInfo();
  }

  Future<void> _getPhoneInfo() async {
    if (Platform.isAndroid) {
      try {
        _androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
      } on PlatformException {
        throw UnimplementedError();
      }
    }
    else if(Platform.isIOS){
      try {
        _iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
      } on PlatformException {
        throw UnimplementedError();
      }
    }
  }

  Future<void> _getPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  Future<String> getOperatingSystem() async => Platform.operatingSystem;

  Future<dynamic> getPhoneInfo() async {
    if (Platform.isAndroid) {
      return _androidDeviceInfo;
    }
    else if (Platform.isIOS) {
      return _iosDeviceInfo;
    } else {
      throw UnimplementedError();
    }
  }

  Future<String?> getIPAddress() async {
    try {
      final url = Uri.parse('https://api.ipify.org');
      final response = await http.get(url);

      return response.statusCode == 200 ? response.body : null;
    } catch (e) {
      return null;
    }
  }

  Future<PackageInfo> getPackageInfo() async {
    return _packageInfo;
  }

  Future<String> getImeiNumber() async {
    bool hasPermission = await Permissions().checkAndRequestPermissions();
    if (!hasPermission) {
      return 'Permission denied.';
    }

    String imeiNumber = '';
    try {
      // imeiNumber = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      imeiNumber = await DeviceInformation.deviceIMEINumber;
    } on PlatformException {
      imeiNumber = 'Failed to get IMEI number.';
    }
    return imeiNumber;
  }

  Future<Position> getCurrentPosition() async {
    Position position;
    final hasPermission = await Permissions().handleLocationPermissions();

    if (!hasPermission) throw UnimplementedError("No Permission access!") ;
    position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  Future<DeviceModel> createDeviceModel() async {
    await initialize();

    final operatingSystem = await getOperatingSystem();
    final phoneInfo = await getPhoneInfo();
    final ipAddress = await getIPAddress();
    final packageInfo = await getPackageInfo();
    final imeiNumber = await getImeiNumber();
    final currentPosition = await getCurrentPosition();

    return DeviceModel(
      operatingSystem: operatingSystem,
      phoneInfo: phoneInfo,
      ipAddress: ipAddress,
      packageInfo: packageInfo,
      imeiNumber: imeiNumber,
      currentPosition: currentPosition,
    );
  }
}