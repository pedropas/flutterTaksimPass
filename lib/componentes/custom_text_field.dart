import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.hint,
      this.prefix,
      required this.label,
      this.suffix,
      this.obscure = false,
      this.textInputType,
      required this.onChanged,
      required this.enabled,
      required this.controller,
      this.maskTextInputFormatter,});

  final TextEditingController controller;
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? textInputType;
  final Function(String) onChanged;
  final bool enabled;
  final String label;
  final MaskTextInputFormatter? maskTextInputFormatter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 5 ,),
          child: Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              label,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: prefix != null ? null : const EdgeInsets.only(left: 16),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: textInputType,
            onChanged: onChanged,
            enabled: enabled,
            inputFormatters: maskTextInputFormatter != null ? [maskTextInputFormatter!] : null,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              prefixIcon: prefix,
              suffixIcon: suffix,
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ],
    );
  }
}
