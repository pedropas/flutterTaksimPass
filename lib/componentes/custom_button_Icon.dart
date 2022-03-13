import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomButtonIcon extends StatelessWidget {
  CustomButtonIcon({
    required this.prefix,
    required this.label,
    required this.suffix,
    required this.icon,
    required this.onTap,
    required this.enabled,
    required this.espaco,
    required this.backgroundCor,
    required this.elevacao,
    required this.textoCor,
    required this.radius,
    required this.fontSize,
  });

  final bool prefix;
  final bool suffix;
  final VoidCallback onTap;
  final bool enabled;
  final String label;
  final IconData icon;
  final double espaco;
  final Color backgroundCor;
  final Color textoCor;
  final double elevacao;
  final double radius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: elevacao,
        primary: backgroundCor,
        shadowColor: Colors.black,
        side: BorderSide(
          width: 1,
          color: backgroundCor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Row(
        children: [
          Container(child: prefix ? Icon(icon) : null),
          Container(
              child: prefix
                  ? SizedBox(
                      width: espaco,
                    )
                  : null),
          Text(label, style: TextStyle(color: textoCor, fontSize: fontSize),),
          Container(
              child: suffix
                  ? SizedBox(
                      width: espaco,
                    )
                  : null),
          Container(child: suffix ? Icon(icon) : null),
        ],
      ),
    ));
  }
}
