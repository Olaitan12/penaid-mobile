import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:penaid/models/api.dart';
import 'package:flutter/services.dart' show rootBundle;

class API {
  Uri _baseUrl;
  Map<String, String> _headers = {"Content-Type": "application/json"};
  var _api;

  Future<APIResponseModel> postRequest(
      String path, Map<String, dynamic> data) async {
    var body = json.encode(data);
    _api = await _apiResources();
    print(_api);
    http.Response response = await http
        .post("${_api.baseUrl}/$path", headers: _api.headers, body: body)
        .timeout(
      Duration(seconds: 15),
      onTimeout: () {
        // time has run out, do what you wanted to do
        return null;
      },
    );
    if (response == null) return APIResponseModel(false, "Timed out", null);
    return _responseHandler(response);
  }

  APIResponseModel _responseHandler(http.Response response) {
    return APIResponseModel.fromJson(json.decode(response.body));
  }

  updateHeaderWithToken(String token) {
    this._headers.update("Authorization", (value) => token);
  }

  Future<dynamic> getRequest(String path) async {
    _api = await _apiResources();
    http.Response response =
        await http.get("${_api._baseUrl}/$path", headers: _headers).timeout(
      Duration(seconds: 15),
      onTimeout: () {
        // time has run out, do what you wanted to do
        return null;
      },
    );

    if (response == null) return APIError("Timed out");
    if (response.statusCode == 200)
      return json.decode(response.body);
    else
      return APIError("Server currently unavailable");
  }

  Future<dynamic> putRequest(String path, Map<String, String> data) async {
    final body = json.encode(data);

    var response = await http
        .put("${_api._baseUrl}/api/$path", headers: _headers, body: body)
        .timeout(
      Duration(seconds: 15),
      onTimeout: () {
        return null;
      },
    );

    if (response == null) return APIError("Timed out");
    if (response.statusCode == 200)
      return response.body;
    else
      return APIError("Server currently unavailable");
  }

  Future<APIModel> _apiResources() async {
    // var apiUrl;
    String _dataString = await rootBundle.loadString("assets/_secure/api.json");
    Map _api = json.decode(_dataString);

    APIModel apiModel = APIModel.fromJson(_api, _headers);
    // print(apiModel.baseUrl);
    return apiModel;
  }
}
