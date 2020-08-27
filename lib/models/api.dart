class APIError {
  final String message;

  APIError(this.message);
}

class APIModel {
  final String baseUrl;
  final Map<String, String> headers;
  APIModel(this.baseUrl, this.headers);
  factory APIModel.fromJson(dynamic json, Map<String, String> headers) {
    return APIModel(json["url"] as String, headers);
  }
}

class APIResponseModel {
  final bool status;
  final String message;
  final dynamic data;
  APIResponseModel(this.status, this.message, this.data);
  factory APIResponseModel.fromJson(dynamic json) {
    return APIResponseModel(
        json["status"] as bool, json["message"] as String, json["data"]);
  }
}
