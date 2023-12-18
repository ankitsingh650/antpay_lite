

import 'package:antpay_lite/repository/common/common_api_repo.dart';
import 'package:flutter/cupertino.dart';

import '../../data/retrofit/auth.dart';
import '../../model/payment/generateRazorpayorderBean.dart';
import '../../preferences/session_ manager.dart';



class GenerateRazorpayorderViewModel with ChangeNotifier {
 late GenerateRazorpayorderBean generateRazorpayorderBeanak;


 Future<GenerateRazorpayorderBean> generateRazorpayorder(GenerateRazorpayorderModel data) async {
   CommonApiRepo commonApiRepoclass = CommonApiRepo();
   print(SessionManager().getToken().toString());
   generateRazorpayorderBeanak = await commonApiRepoclass.apiClient.generateRazorpayorder(data,AuthToken.getAuthToken(),SessionManager().getToken().toString());
   print('State Response:\nStatus: ${generateRazorpayorderBeanak.api_key}\n');
   return generateRazorpayorderBeanak;
 }

}

