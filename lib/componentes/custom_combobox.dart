import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomComboBox extends StatelessWidget {
  String label;
  String hintText;
  Color listColor;
  String valorEscolhido;
  List listItens;
  Function(Object?)? selectedValue;

  CustomComboBox(
      {required this.hintText,
      required this.listColor,
      required this.listItens,
      required this.valorEscolhido,
      required this.label,
      required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButton(
            hint: Text(hintText),
            dropdownColor: listColor,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            isExpanded: true,
            underline: SizedBox(),
            value: valorEscolhido,
            onChanged: selectedValue,
            items: listItens.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
