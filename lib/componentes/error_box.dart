import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  ErrorBox({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null)
      return Container();
    else
      return Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  'Ops! $message. Por favor, verifique!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
