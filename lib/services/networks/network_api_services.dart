import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news/services/exception.dart';

class NetworkApiServices {
  Future<dynamic> getApiResponse(String url) async {
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      return responseResult(response);
    } on SocketException {
      FetchDataException();
    }
  }

  responseResult(http.Response responseIs) {
    switch (responseIs.statusCode) {
      case 200:
        return jsonDecode(responseIs.body.toString());
      case 400:
        throw BadRequestException(responseIs.body.toString());
      case 202:
        throw UnauthorizedException(responseIs.body.toString());
      default:
        throw FetchDataException(responseIs.body.toString());
    }
  }
}
