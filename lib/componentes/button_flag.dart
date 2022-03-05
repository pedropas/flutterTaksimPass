import 'package:flutter/material.dart';

import '../helpers/config_screen.dart';

class ButtonFlag extends StatelessWidget {

  String flagImage;
  String flagName;
  bool isSelected;
  VoidCallback onIdiomaSelecionado;

  ButtonFlag({required this.flagImage,required this.flagName, required this.isSelected, required this.onIdiomaSelecionado});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 110,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 3.0, color: isSelected ? BUTTON_COLOR : Colors.grey.shade200),
          backgroundColor: Colors.grey[200],
        ),
        onPressed: onIdiomaSelecionado,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(flagImage, width: 55,),
            Text(
              flagName,
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
