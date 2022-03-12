import 'package:flutter/material.dart';

class ImageIconCuston extends StatelessWidget {
  ImageIconCuston({this.imageB64});

  final Image? imageB64;

  @override
  Widget build(BuildContext context) {
    if (imageB64 == null) {
      return Container(
        child: Icon(Icons.person, color: Colors.white, size: 45,),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 70,
          child: Image(
            image: imageB64!.image,
          ),
        ),
      );
    }
  }
}
