import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:taksim/componentes/drawer/page_tile.dart';

import '../../pages/base/page_store.dart';

class PageSection extends StatelessWidget {
  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Histórico
        PageTile(
          label: 'Histórico de viagem',
          iconData: Icons.flag,
          onTap: () {pageStore.setPage(2);},
          highlighted: pageStore.page == 2,
          isShow: pageStore.isShow,
          isPronto: true,
        ),
        // Notificação
        PageTile(
          label: 'Notificação',
          iconData: Icons.notifications,
          onTap: () {pageStore.setPage(3);},
          highlighted: pageStore.page == 3,
          isShow: pageStore.isShow,
          isPronto: true,
        ),
        // Método de pagamento
        PageTile(
          label: 'Método de pagamento',
          iconData: Icons.wallet_membership ,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
        // Voucher
        PageTile(
          label: 'Voucher',
          iconData: Icons.airplane_ticket,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
        // Destino Favorito
        PageTile(
          label: 'Destino favorito',
          iconData: Icons.star ,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
        // Amigos de confiança
        PageTile(
          label: 'Amigos de confiança',
          iconData: Icons.verified_user ,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
        // Indicar amigos
        PageTile(
          label: 'Indicar amigos',
          iconData: Icons.gif_box ,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
        // Resgatar cupom
        PageTile(
          label: 'Resgatar cupom',
          iconData: Icons.currency_pound ,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
        // Extrato
        PageTile(
          label: 'Extrato',
          iconData: Icons.wordpress,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
        // Ajuda
        PageTile(
          label: 'Ajuda',
          iconData: Icons.help ,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
        // Configurações
        PageTile(
          label: 'Configurações',
          iconData: Icons.settings ,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
        // Sair
        PageTile(
          label: 'Sair',
          iconData: Icons.exit_to_app ,
          onTap: () {pageStore.setPage(1);},
          highlighted: pageStore.page == 1,
          isShow: pageStore.isShow,
          isPronto: false,
        ),
      ],
    );
  }
}
