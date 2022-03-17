import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taksim/dominio/ent_frota.dart';
import 'package:taksim/helpers/config_screen.dart';

class ItemVeiculo extends StatelessWidget {
  const ItemVeiculo(this.frota);

  final EntFrota frota;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      color: Colors.grey.shade50,
      height: 60,
      child: Row(
        children: <Widget>[
          frota.getImageFoto() ??
              Image.asset(
                'assets/images/taxi.png',
                height: 50,
                width: 50,
              ),
          Container(
            width: 180,
            padding: EdgeInsets.only(left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  frota.nomeFrota,
                  style: const TextStyle(fontFamily: 'Montserrat Bold'),
                ),
                Text(
                  frota.placaModelo,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: BUTTON_COLOR,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 15),
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  frota.distanciaEstimado,
                  style: TextStyle(fontFamily: 'Montserrat Bold'),
                ),
                Text(
                  frota.tempoEstimado,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: BUTTON_COLOR,
                  ),
                ),
                Text(
                  frota.percentualDesconto.toString()+" %",
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: BUTTON_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
