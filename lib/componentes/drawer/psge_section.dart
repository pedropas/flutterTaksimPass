import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taksim/componentes/drawer/page_tile.dart';

import '../../pages/base/page_store.dart';

class PageSection extends StatelessWidget {
  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTile(
          label: 'Teste Desacoplador',
          iconData: Icons.app_blocking,
          onTap: () {pageStore.setPage(2);},
          highlighted: pageStore.page == 2,
          isShow: pageStore.isShow,
          isPronto: true,
        ),
        PageTile(
          label: 'Visualizar Mapa',
          iconData: Icons.map_outlined,
          onTap: () {pageStore.setPage(3);},
          highlighted: pageStore.page == 3,
          isShow: pageStore.isShow,
          isPronto: true,
        ),

        PageTile(
          label: 'Perfil',
          iconData: Icons.person ,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
      ],
    );
  }
}
