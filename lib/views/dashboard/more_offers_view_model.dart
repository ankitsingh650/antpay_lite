
import 'package:flutter/cupertino.dart';

import '../../model/homebanner/offer_details_by_category_model.dart';
import '../../model/miscellaneous/offer_details_by_category_model.dart';
import '../../repository/common/common_api_repo.dart';

class MoreOffersViewModel with ChangeNotifier{


  String _category='';

  String get category =>_category;

  setCategory(String value){
    _category=value;
    notifyListeners();
  }

Future<dynamic> getOfferDetailsByCategories(OfferDetailsByCategoryRequest request) async {
  CommonApiRepo repoClass = CommonApiRepo();
  OfferDetailsByCategoryResponse response = await repoClass.apiClient.fetchOfferByCategory(request);

  return response.details;
}
}