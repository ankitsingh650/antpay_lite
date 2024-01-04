

import 'package:flutter/cupertino.dart';

import '../../data/retrofit/auth.dart';
import '../../model/wallet/AadhaarCardRequest.dart';
import '../../model/wallet/PanKYCResponseModel.dart';
import '../../preferences/session_ manager.dart';
import '../../repository/common/common_api_repo.dart';

class MinKycViewModel with ChangeNotifier {

  CommonApiRepo repoClass = CommonApiRepo();

  Future<PanKYCResponseModel> minKycAadhar(String enteredNumber) async {
    String? fetchUserName = "";
    //setLoading(true);

    AadhaarCardRequest req = AadhaarCardRequest(p1:  enteredNumber);
    PanKYCResponseModel response = await repoClass.apiClient.minKycaadhar(  AuthToken.getAuthToken(),
        SessionManager().getToken().toString(),req);

 /*   print('minKyc Response:\nStatus: \nfname: ${response.message}');

    fetchUserName = "${response.statusCode} ${response.message}";

  //  setLoading(false);

    print('fetchuser: $fetchUserName');*/
    return response;
  }


}