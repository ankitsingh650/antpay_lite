
import 'package:flutter/cupertino.dart';

import '../../model/homebanner/offer_details_model.dart';
import '../../repository/common/common_api_repo.dart';


class OfferViewModel with ChangeNotifier{

  Future<dynamic> getOfferDetails(OfferDetailsRequest offerID) async {
    CommonApiRepo repoClass = CommonApiRepo();
    OfferDetailsResponse response = await repoClass.apiClient.fetchOfferDetails(offerID);

    return response.details;
  }

}