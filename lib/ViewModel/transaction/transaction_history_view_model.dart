
import 'package:flutter/cupertino.dart';

import '../../../preferences/session_ manager.dart';
import '../../model/transaction/transaction_history_model.dart';
import '../../repository/common/common_api_repo.dart';
import '../../utils/common_utils.dart';

class TransactionHistoryViewModel with ChangeNotifier {

  String _range = '';

  setRange(String value) {
    _range = value;
    notifyListeners();
  }

  String get range => _range;

 /* Future<fetchStatementResponseModel> (
      BuildContext context, fetchStatementRefetchTransactionsquestModel data) async {
    CommonApiRepo repoClass = CommonApiRepo();
    fetchStatementResponseModel response;
    print('::: ${data.mobile}-${data.pageNo}--${data.txnStartDate}--${data.txnEndDate}');
    if(EnvironmentConfig().envStatus.toString()=='PROD'){
      print('Fetch Transaction call production');
      response =
      await repoClass.fetchTransaction(SessionManager().getToken().toString(), AuthToken.getAuthToken(), data);else
   // }
    else {
      print('Fetch Transaction call dev');
      response = await repoClass.fetchTransaction_UAT(AuthToken.getAuthToken(), data);
    }



    return response;
  }*/
}
