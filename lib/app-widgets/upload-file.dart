import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/services/api.dart';
import 'package:penaid/services/data.dart';
import 'package:penaid/services/upload.dart';

class DocumentUpload extends StatefulWidget {
  final String type;
  final String uploadFileDescription;
  final UploadDocumentType documentType;
  DocumentUpload({
    this.type,
    @required this.documentType,
    this.uploadFileDescription,
  });
  _DocumentUpload createState() => _DocumentUpload();
}

class _DocumentUpload extends State<DocumentUpload> {
  UploadService _uploadService;
  String _filePath;

  AppUserData _data = GetIt.I<AppUserData>();
  isImage() {
    return _filePath != null
        ? _filePath.substring(_filePath.length - 4, _filePath.length - 1) ==
            ".jpg"
        : false;
  }

  initUploadService(BuildContext context) {
    _uploadService = UploadService(
        context: context,
        onSelected: _setFilePath,
        uploadDocumentType: widget.documentType,
        userId: _data.accessData.userId);
  }

  void _setFilePath(String filePath) => setState(() {
        _filePath = filePath;
      });
  Widget build(BuildContext context) {
    initUploadService(context);
    return Container(
      height: 310,
      width: 270,
      decoration: BoxDecoration(
        color: Colors.orange[50],
        image: DecorationImage(
          image:
              _filePath != null ? AssetImage(_filePath) : NetworkImage("http"),
          fit: BoxFit.fitWidth,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: InkWell(
        onTap: _uploadService.upload,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.documentType != UploadDocumentType.bankStatement
                  ? ImageIcon(
                      AssetImage("assets/icons/image-upload.png"),
                      size: 50,
                      color: Colors.orange,
                    )
                  : ImageIcon(
                      AssetImage("assets/icons/pdf-upload.png"),
                      size: 50,
                      color: Colors.orange,
                    ),
              Text(widget.type ?? ""),
              Text(widget.uploadFileDescription ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
