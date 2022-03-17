import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextFieldBloc extends StatelessWidget {
  CustomTextFieldBloc(
      {required this.hint,
      this.prefix,
      required this.label,
      this.suffix,
      this.obscure = false,
      this.textInputType,
      required this.onChanged,
      required this.enabled,
      this.maskTextInputFormatter,
      required this.stream});

  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? textInputType;
  final Function(String) onChanged;
  final bool enabled;
  final String label;
  final MaskTextInputFormatter? maskTextInputFormatter;
  final Stream<String> stream;

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
          child: StreamBuilder<String>(
            stream: stream,
            builder: (context, snapshot) {
              return TextField(
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
                  errorText: snapshot.hasError ? snapshot.error as String : null,
                ),
                textAlignVertical: TextAlignVertical.center,
              );
            }
          ),
        ),
      ],
    );
  }
}
