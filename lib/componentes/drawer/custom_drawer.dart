import 'package:flutter/material.dart';
import 'package:taksim/componentes/drawer/psge_section.dart';

import 'custom_drawer_header.dart';
class CustomDrawer extends StatelessWidget {

  const CustomDrawer({required this.eMail,
    required this.nomeCompleto,
    required this.foto, Key? key}) : super(key: key);

  final Image foto;
  final String nomeCompleto;
  final String eMail;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(50)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .70,
        child: Drawer(
          child: ListView(
            children: [
              CustomDrawerHeader(eMail: eMail, foto: foto, nomeCompleto: nomeCompleto),
              PageSection(),
            ],
          ),

        ),
      ),
    );
  }
}

