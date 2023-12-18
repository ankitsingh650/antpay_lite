
class FetchUserModel {
  String? status;
  String? fname;
  String? lname;
  String? msg;

  FetchUserModel({this.status, this.fname, this.lname, this.msg});

  FetchUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    fname = json['fname'];
    lname = json['lname'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['msg'] = this.msg;
    return data;
  }
}