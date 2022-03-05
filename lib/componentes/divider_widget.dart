import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {

  Color corLinha;

  DividerWidget({required this.corLinha});

  @override
  Widget build(BuildContext context) {
    return Divider(
        height: 1.0,
        color: corLinha,
        thickness: 1.0,
    );
  }
}
