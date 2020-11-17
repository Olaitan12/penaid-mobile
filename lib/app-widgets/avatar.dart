import 'package:flutter/material.dart';
import 'package:penaid/constants.dart';

class ClientAvatar extends StatelessWidget {
  final double size;
  final double width;
  final double height;
  final String userId;
  final String uploadImagePath;

  ClientAvatar(
      {this.size, this.userId, this.width, this.height, this.uploadImagePath});

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPhotoFile(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              debugPrint("================================");
              debugPrint(snapshot.data);
              debugPrint("================================");
              String url = "${snapshot.data}/$userId/photo.jpg";
              return Stack(children: [
                Container(
                  child:
                      Icon(Icons.person, size: size, color: Colors.lightBlue),
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  // constraints: BoxConstraints.tight(Size.fromWidth(width)),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlue),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  // constraints: BoxConstraints.tight(Size.fromWidth(width)),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlue),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: uploadImagePath != null
                            ? AssetImage(uploadImagePath)
                            : NetworkImage(url),
                        fit: BoxFit.cover,
                        onError: (x, y) {
                          if (x is NetworkImageLoadException)
                            debugPrint(x.statusCode.toString());
                          // debugPrint(y.toString());
                        }),
                  ),
                )
              ]);
              break;
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        });
  }
}
