import 'package:flutter/material.dart';

import '../model/get_api_model.dart';
import '../repository/home_repositery.dart';
import '../services/response/api_status_response.dart';

class HomeViewModel with ChangeNotifier {
  final HomeRepository objectHomeRepo = HomeRepository();

  ApiStatusResponse<GetApiModel> getApiData = ApiStatusResponse.loading();

  int _carouselCurrentIndex = 0;

  int get carouselCurrentIndex => _carouselCurrentIndex;

  setApiData(ApiStatusResponse<GetApiModel> response) {
    getApiData = response;
    notifyListeners();
  }

  void updateCarouselIndex(int index) {
    _carouselCurrentIndex = index;
    notifyListeners();
  }

  Future<void> fetchGetApiData() async {
    setApiData(ApiStatusResponse.loading());
    try {
      final data = await objectHomeRepo.fetchData();
      setApiData(ApiStatusResponse.complete(data));
    } catch (error) {
      setApiData(ApiStatusResponse.error(error.toString()));
    }
  }
}
