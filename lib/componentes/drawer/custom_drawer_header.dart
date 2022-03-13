import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import 'package:taksim/helpers/config_screen.dart';

import '../image_icon_custon.dart';


class CustomDrawerHeader extends StatelessWidget {

  CustomDrawerHeader({
  required this.eMail,
  required this.nomeCompleto,
  required this.foto});

  final Image foto;
  final String nomeCompleto;
  final String eMail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ },
      child: Container(
        color: BUTTON_COLOR,
        height: 95,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            ImageIconCuston(imageB64: foto),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(nomeCompleto, style: TextStyle(color: Colors.white, fontFamily: "Montserrat Bold")),
                  Text('Editar seu perfil', style: TextStyle(color: Colors.white, fontFamily: "Montserrat")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
