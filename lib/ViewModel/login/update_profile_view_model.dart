

import 'package:flutter/cupertino.dart';

import '../../preferences/session_ manager.dart';

class UpdateProfileViewModel with ChangeNotifier{

  String _gender='';
  String _industry='';
  String _state='';
  String _stateCode='';
  String _city='';
  String _cityCode='';
  String _occupation='';
  String _mccCode = '';

  String get gender=>_gender;
  String get Education=>_industry;
  String get state=>_state;
  String get stateCode=>_stateCode;
  String get city=>_city;
  String get cityCode=>_cityCode;
  String get occupation =>_occupation;
  String get ocupationsalar => _mccCode;


  setGender(String value){
    _gender=value;
    notifyListeners();
  }
  setIndustry(String value){
    _industry=value;
    notifyListeners();
  }
  setState(String value){
    _state=value;
    notifyListeners();
  }
  setStateCode(String value){
    _stateCode=value;
    notifyListeners();
  }
  setCity(String value){
    _city=value;
    notifyListeners();
  }
  setCityCode(String value){
    _cityCode=value;
    notifyListeners();
  }
  setOccupation(String value){
    _occupation=value;
    notifyListeners();
  }
  setMccCode(String value) {
    _mccCode = value;
    notifyListeners();
  }

  }
