import 'dart:convert';
import 'dart:io';

// import 'package:cewers/bloc/send-report.dart';
// import 'package:cewers/controller/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:cewers/extensions/string.dart';
import 'package:crypto/crypto.dart';
import 'package:image_picker/image_picker.dart';

class UploadNotifier extends ChangeNotifier {
  final Dio _dio = Dio();
  double progressPercentage;
  String errorMessage;
  String status;
  String imagePath;

  void setError(Exception error) {
    if (error is DioError) {
      errorMessage = error.toString();
    } else if (error is Exception) {
      errorMessage = (error.toString().replaceRange(0, 11, ""));
    } else {
      errorMessage = (error.toString());
    }
    notifyListeners();
  }

  Future<void> pickFile(ImageSource source) async {
    File image = await ImagePicker.pickImage(
        source: source, preferredCameraDevice: CameraDevice.front);
    debugPrint(image.path);
    imagePath = image.path;
  }

  Future<void> uploadImage(
      String imagePath, String imageFilename, int timeStamp) async {
    final credentials = await rootBundle.loadString("assets/_secure/api.json");
    // print(credentials);
    // APIKeys auth = APIKeys.fromJson(json.decode(credentials));

    Map<String, dynamic> params = new Map();

    params["file"] =
        await MultipartFile.fromFile(imagePath, filename: imageFilename);

    FormData formData = new FormData.fromMap(params);
    // var progress;
    Dio dio = await getApiClient();
    dio
        .post("cousant/auto/upload", data: formData, onSendProgress: progress)
        .catchError((e, stack) {
      errorMessage = e.toString();
    });
  }

  Future<String> getSignature(
      String folder, String publicId, int timeStamp) async {
    var buffer = new StringBuffer();

    buffer.write("timestamp=" + timeStamp.toString());

    var bytes = utf8.encode(buffer.toString().trim()); // data being hashed

    return sha1.convert(bytes).toString();
  }

  Future<Dio> getApiClient({InterceptorsWrapper interceptor}) async {
    String secretFile = await rootBundle.loadString("assets/_secret/api.json");
    Map fileData = json.decode(secretFile);
    _dio.options.baseUrl = fileData["url1"];
    _dio.interceptors.clear();
    if (interceptor != null) {
      _dio.interceptors.add(interceptor);
    }
    return _dio;
  }

  progress(int actualBytes, int totalBytes) {
    // print("========");
    progressPercentage = actualBytes / totalBytes * 100;
    status = "${progressPercentage.toStringAsFixed(1)}% Uploading...";
    if (progressPercentage == 100) status = "Completed";
    notifyListeners();
  }
}

class UploadPayloadModel {
  final FormData formData;
  final Dio dio;
  UploadPayloadModel(this.dio, this.formData);
}
