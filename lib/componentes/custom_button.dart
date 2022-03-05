import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  String imageName;
  bool comSombra;
  Color backGroundColor;
  VoidCallback buttonFunction;

  CustomButton({required this.imageName,
                required this.comSombra,
                required this.backGroundColor,
                required this.buttonFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonFunction,
      child: Container(
        decoration: comSombra ? BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 6.0,
              spreadRadius: 0.5,
              offset: Offset(0.7, 0.7),
            ),
          ],
        ) : null,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Image.asset(imageName, width: 50, height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}



