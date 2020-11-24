import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penaid/services/api.dart';

class UploadService {
  final BuildContext context;
  final Function(String) onSelected;
  final String userId;
  final UploadDocumentType uploadDocumentType;

  UploadService(
      {this.context, this.onSelected, this.userId, this.uploadDocumentType});

  Map<UploadDocumentType, String> selectedFile = {
    UploadDocumentType.passport: "photo",
    UploadDocumentType.utilityBill: "nepa_bill",
    UploadDocumentType.retirementDocument: "retirement_document",
    UploadDocumentType.bankStatement: "bank_statement",
    UploadDocumentType.identityCard: "identity_card"
  };
  API api = GetIt.I<API>();

  Future<void> pickFile(ImageSource source) async {
    File file = await ImagePicker.pickImage(
        source: source, preferredCameraDevice: CameraDevice.front);
    onSelected(file.path);

    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              width: 150,
              height: 100,
              child: Card(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Uploading "), CircularProgressIndicator()],
              )),
            ),
          );
        });
    try {
      var res = await api.uploadImage(
          file.path, userId, selectedFile[uploadDocumentType]);
      debugPrint(res);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
    }
    // if (Platform.isIOS) {
    // } else {}
  }

  void upload() {
    showDialog(
      builder: (context) {
        return Center(
            child: SizedBox(
          width: 250,
          height: 160,
          child: Card(
            child: Container(
              padding: EdgeInsets.all(30),
              width: 250,
              height: 150,
              child: Column(children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Column(
                      //   children: [
                      InkWell(
                        onTap: () {
                          pickFile(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        child: Column(children: [
                          Image.asset(
                            "assets/icons/gallery.png",
                            width: 45,
                          ),
                          Text("Photos"),
                        ]),
                      ),
                      InkWell(
                        onTap: () {
                          pickFile(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        child: Column(children: [
                          Image.asset(
                            "assets/icons/camera.png",
                            width: 45,
                          ),
                          Text("Camera"),
                        ]),
                      ),
                    ],
                  ),
                  //   ],
                  // ),
                ),
              ]),
            ),
          ),
        ));
      },
      context: context,
    );
  }
}
