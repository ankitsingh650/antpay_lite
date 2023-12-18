
class DeviceInfoModel {

  String? ipAddress;
  String? latitude;
  String? longitude;
  String? location;
  String? os;
  String? imeiNumber;
  String? referralCode;
  String? versionName;
  String? versionNumber;
  String? modelName;
  String? modelNumber;

  DeviceInfoModel({this.ipAddress, this.latitude, this.longitude, this.location="", this.os="",this.imeiNumber, this.referralCode="null",
                    this.versionName, this.versionNumber, this.modelName, this.modelNumber});
}