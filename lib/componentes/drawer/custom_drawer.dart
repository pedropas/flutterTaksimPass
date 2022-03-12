import 'package:flutter/material.dart';
import 'package:taksim/componentes/drawer/psge_section.dart';

import 'custom_drawer_header.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(50)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .60,
        child: Drawer(
          child: ListView(
            children: [
              CustomDrawerHeader(),
              PageSection(),
            ],
          ),

        ),
      ),
    );
  }
}

