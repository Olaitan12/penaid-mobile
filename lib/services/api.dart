import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penaid/models/api.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http_parser/http_parser.dart' show MediaType;

class API {
  Map<String, String> _headers = {"Content-Type": "application/json"};
  APIModel _api;
  /*
   * All POST request
   */
  Future<APIResponseModel> postRequest(
      String path, Map<String, dynamic> data) async {
    try {
      var body = json.encode(data);
      _api = await _apiResources();
      // print(_api);
      http.Response response = await http
          .post("${_api.baseUrl}/$path", headers: _api.headers, body: body)
          .timeout(
        Duration(seconds: 45),
        onTimeout: () {
          // time has run out, do what you wanted to do
          return null;
        },
      );
      if (response == null) return APIResponseModel(false, "Timed out", null);
      return _responseHandler(response);
    } catch (e) {
      return APIResponseModel(false, e.toString(), null);
    }
  }

  APIResponseModel _responseHandler(http.Response response) {
    try {
      switch (response.statusCode) {
        case 200:
          return APIResponseModel.fromJson(json.decode(response.body));
          break;
        case 400:
          var responseData = json.decode(response.body);
          return APIResponseModel(
              false, responseData["message"] as String, null);
          break;
        case 401:
          return APIResponseModel(false, "Unauthorized access", null);
          break;
        case 403:
          return APIResponseModel(false, "Invalid token", null);
          break;
        case 404:
          return APIResponseModel(false, "Service not implemented", null);
          break;
        case 500:
          return APIResponseModel(false, "Server error!", null);
          break;
        default:
          return APIResponseModel(false, "Unexpected error", null);
          break;
      }
    } catch (e) {
      return APIResponseModel(false, e.toString(), null);
    }
  }

  updateHeaderWithToken(String token) {
    this._headers["Authorization"] = "Bearer $token";
  }

  Future<APIResponseModel> getRequest(String path) async {
    try {
      _api = await _apiResources();
      http.Response response = await http
          .get("${_api.baseUrl}/$path", headers: _api.headers)
          .timeout(
        Duration(seconds: 15),
        onTimeout: () {
          // time has run out, do what you wanted to do
          return null;
        },
      );
      // print(response);
      if (response == null) return APIResponseModel(false, "Timed out", null);
      return _responseHandler(response);
    } catch (e) {
      return APIResponseModel(false, e.toString(), null);
    }
  }

  Future<APIResponseModel> putRequest(
      String path, Map<String, String> data) async {
    try {
      final body = json.encode(data);

      _api = await _apiResources();
      http.Response response = await http
          .put("${_api.baseUrl}/$path", headers: _api.headers, body: body)
          .timeout(
        Duration(seconds: 15),
        onTimeout: () {
          // time has run out, do what you wanted to do
          return null;
        },
      );
      if (response == null) return APIResponseModel(false, "Timed out", null);
      return _responseHandler(response);
    } catch (e) {
      return APIResponseModel(false, e.toString(), null);
    }
  }

  Future<APIModel> _apiResources() async {
    String _dataString = await rootBundle.loadString("assets/_secure/api.json");
    Map _api = json.decode(_dataString);
    _headers["xx-penaid-access"] = _api["token"];
    APIModel apiModel = APIModel.fromJson(_api, _headers);
    return apiModel;
  }

  Future<String> uploadImage(
      String filePath, String userId, String documentName) async {
    debugPrint(_api.versionOneUrl);
    var request = http.MultipartRequest('POST',
        Uri.parse(_api.versionOneUrl + "/file/upload/$userId/$documentName"));
    request.headers["Authorization"] = _headers["Authorization"];
    request.files.add(http.MultipartFile('file',
        File(filePath).readAsBytes().asStream(), File(filePath).lengthSync(),
        filename: filePath.split("/").last,
        contentType: _getFileMimeType(filePath)));
    var res = await request.send();
    // res.stream
    return res.statusCode.toString();
    // debugPrint(res.persistentConnection)
  }

  MediaType _getFileMimeType(String path) {
    if (path.endsWith('.jpg')) {
      return MediaType("image", "jpeg");
    } else if (path.endsWith('.pdf')) {
      return MediaType("application", "pdf");
    } else {
      throw (Exception("Unsupported file format"));
    }
  }

  bool isJpeg(String path) {
    return path.endsWith('.jpg');
  }

  bool isPDF(String path) {
    return path.endsWith('.pdf');
  }
}

enum UploadDocumentType {
  passport,
  bankStatement,
  retirementDocument,
  utilityBill,
  identityCard
}
