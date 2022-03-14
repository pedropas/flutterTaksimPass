import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    required this.radius,
    required this.iconData,
    required this.onTap,
    this.cor = Colors.black,
  });

  final double radius;
  final IconData iconData;
  final VoidCallback onTap;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Icon(iconData),
          onTap: onTap,
        ),
      ),
    );
  }
}
