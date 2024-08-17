import 'package:news/resources/app_url.dart';
import 'package:news/services/networks/network_api_services.dart';
import '../model/get_api_model.dart';
import '../services/exception.dart';

class HomeRepository {
  final networkObject = NetworkApiServices();

  Future<GetApiModel> fetchData() async {
    try {
      dynamic response =
      await networkObject.getApiResponse(AppUrl.getApiEndPoint);
      if (response is Map<String, dynamic>) {
        return GetApiModel.fromJson(response);
      } else {
        throw FetchDataException("Unexpected data format");
      }
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}

