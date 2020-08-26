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
