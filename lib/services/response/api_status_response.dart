import 'package:news/services/response/api_status.dart';

class ApiStatusResponse<T> {
  T? data;
  String? message;
  ApiStatus? status;
  ApiStatusResponse(this.status, this.data, this.message);
  ApiStatusResponse.loading() : status = ApiStatus.apiStatusLoading;
  ApiStatusResponse.complete(this.data) : status = ApiStatus.apiStatusComplete;
  ApiStatusResponse.error(this.message) : status = ApiStatus.apiStatusError;
  @override
  String toString() {
    return "Status : $status \n Data : $data \n Message : $message ";
  }
}
