import 'package:flutter/material.dart';

import '../../helpers/config_screen.dart';

class PageTile extends StatelessWidget {

  PageTile(
      {required this.label, required this.iconData, required this.onTap, required this.highlighted, required this.isShow, required this.isPronto});

  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;
  final bool isShow;
  final bool isPronto;

  @override
  Widget build(BuildContext context) {
    return isShow ? ListTile(
        title: Text(label,
            style: TextStyle(
                color: Colors.black)
        ),
    leading: Icon(iconData,
    color: highlighted ? Colors.blue : BUTTON_COLOR),
    onTap: onTap,
    enabled: isPronto,
    ) :
    ListTile();
  }
}
