import 'package:flutter/material.dart';
import 'package:penaid/services/api.dart';

class DocumentUpload extends StatefulWidget {
  final String type;
  final String uploadFileDescription;
  final UploadDocumentType documentType;
  DocumentUpload({this.type, this.uploadFileDescription, this.documentType});
  _DocumentUpload createState() => _DocumentUpload();
}

class _DocumentUpload extends State<DocumentUpload> {
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      width: 270,
      decoration: BoxDecoration(
        color: Colors.orange[50],
        // boxShadow: ,
        // border: Border.all(style: BorderStyle.solid),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_file,
              size: 50,
              color: Colors.orange,
            ),
            Text(widget.type ?? ""),
            Text(widget.uploadFileDescription ?? ""),
          ],
        ),
      ),
    );
  }
}
