import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taksim/dominio/ent_passageiro.dart';

import '../../pages/base/page_store.dart';
import '../image_icon_custon.dart';


class CustomDrawerHeader extends StatelessWidget {

  EntPassageiro passageiro = EntPassageiro();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ },
      child: Container(
        color: Colors.blue,
        height: 95,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            ImageIconCuston(imageB64: passageiro.isLogado ?
                              passageiro.getImageFoto() : null),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(passageiro.isLogado ?
                      passageiro.nomeCompleto  :
                      'Acesse sua conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                  ),
                  Text(passageiro.isLogado ?
                  passageiro.eMail :
                  'Clique aqui',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
