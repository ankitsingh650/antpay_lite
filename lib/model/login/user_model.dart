class UserModel {
  Data? data;
  int? status;
  String? msg;

  UserModel({this.data, this.status, this.msg});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    data = json["0"] != null ? new Data.fromJson(json["0"]) : null;
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  String? name;
  String? mobile;
  String? firebaseToken;
  String? ipAddress;
  String? latitude;
  String? longitude;
  String? location;
  String? os;
  String? imeiNo;
  String? referralCode;
  String? versionName;
  dynamic versionNumber;
  String? modelName;
  String? modelNo;

  Data(
      {this.name,
        this.mobile,
        this.firebaseToken,
        this.ipAddress,
        this.latitude,
        this.longitude,
        this.location,
        this.os,
        this.imeiNo,
        this.referralCode,
        this.versionName,
        this.versionNumber,
        this.modelName,
        this.modelNo});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    firebaseToken = json['firebaseToken'];
    ipAddress = json['ipAddress'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    os = json['os'];
    imeiNo = json['imeiNo'];
    referralCode = json['referralCode'];
    versionName = json['versionName'];
    versionNumber = json['versionNumber'];
    modelName = json['modelName'];
    modelNo = json['modelNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['firebaseToken'] = this.firebaseToken;
    data['ipAddress'] = this.ipAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['os'] = this.os;
    data['imeiNo'] = this.imeiNo;
    data['referralCode'] = this.referralCode;
    data['versionName'] = this.versionName;
    data['versionNumber'] = this.versionNumber;
    data['modelName'] = this.modelName;
    data['modelNo'] = this.modelNo;
    return data;
  }
}