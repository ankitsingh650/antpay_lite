import 'package:antpay_lite/utils/permissions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';

class CommonMethodUtils {
  static final CommonMethodUtils _instance = CommonMethodUtils._internal();

  factory CommonMethodUtils() {
    return _instance;
  }

  CommonMethodUtils._internal();

  Future<Position> getCurrentPosition() async {
    Position position;
    final hasPermission = await Permissions().handleLocationPermissions();

    if (!hasPermission) throw UnimplementedError("No Permission access!");
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  Future<Position> getCoordinates() async {
    Position currentPosition = await getCurrentPosition();
    return currentPosition;
  }

  String? dateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }

    // Parse the user input string to DateTime
    DateTime? selectedDate;
    try {
      selectedDate = DateFormat('dd/MM/yyyy').parse(value);
    } catch (e) {
      return 'Invalid date format';
    }

    // Calculate the difference between the selected date and the current date
    Duration difference = DateTime.now().difference(selectedDate);

    // Check if the selected date is in the future
    if (difference.isNegative) {
      return 'Invalid date';
    }
    if (DateTime.now().year - selectedDate!.year < 18)
      return 'DOB must be greater than 18 Yrs';
    if (DateTime.now().year - selectedDate!.year == 18) {
      // Check months and days if the years are the same
      if (DateTime.now().month < selectedDate!.month)
        return 'DOB must be greater than 18 Yrs';
      if (DateTime.now().month == selectedDate!.month &&
          DateTime.now().day < selectedDate!.day)
        return 'DOB must be greater than 18 Yrs';
    }

    return null;
  }

  String? dateValidatorBL(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }

    // Parse the user input string to DateTime
    DateTime? selectedDate;
    try {
      selectedDate = DateFormat('dd-MM-yyyy').parse(value);
    } catch (e) {
      return 'Invalid date format';
    }

    // Calculate the difference between the selected date and the current date
    Duration difference = DateTime.now().difference(selectedDate);

    // Check if the selected date is in the future
    if (difference.isNegative) {
      return 'Invalid date';
    }
    if (DateTime.now().year - selectedDate!.year < 18)
      return 'DOB must be greater than 18 Yrs';
    if (DateTime.now().year - selectedDate!.year == 18) {
      // Check months and days if the years are the same
      if (DateTime.now().month < selectedDate!.month)
        return 'DOB must be greater than 18 Yrs';
      if (DateTime.now().month == selectedDate!.month &&
          DateTime.now().day < selectedDate!.day)
        return 'DOB must be greater than 18 Yrs';
    }

    return null;
  }

  //  Check image url redirect to default browser and external social app
  /* linkLanuchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    }
    else {
      throw 'Could Not launch $url';
    }
  }*/

  String showLoanDate(String date) {
    DateTime originalDate = DateTime.parse(date);

    String formattedDate = DateFormat('dd-MM-yyyy').format(originalDate);

    return formattedDate;
  }

  String formatRangeDate(String date) {
    DateTime originalDate = DateTime.parse(date);

    String formattedDate = DateFormat('dd-MM-yyyy').format(originalDate);

    return formattedDate;
  }

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    String? id = '';
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      id = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      id = androidDeviceInfo.id; // unique ID on Android
    }
    return id ?? 'NULL';
  }

  Future<String?> getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    return appVersion;
  }
}
