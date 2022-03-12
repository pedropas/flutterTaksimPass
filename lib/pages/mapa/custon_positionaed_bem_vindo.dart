import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';

import '../../DataHandler/appData.dart';
import '../../componentes/divider_widget.dart';
import '../search/searchScreen.dart';

class CustonPositionBemVindo extends StatefulWidget {
  const CustonPositionBemVindo(
      {Key? key,
      required this.bemVindoContainerHeight,
      required this.displayBemVindoContainer})
      : super(key: key);

  final double bemVindoContainerHeight;
  final Function displayBemVindoContainer;

  @override
  _CustonPositionBemVindoState createState() => _CustonPositionBemVindoState(
      bemVindoContainerHeight: bemVindoContainerHeight,
      displayBemVindoContainer: displayBemVindoContainer);
}

class _CustonPositionBemVindoState extends State<CustonPositionBemVindo> {
  double bemVindoContainerHeight = 0;
  late Function displayBemVindoContainer;

  _CustonPositionBemVindoState(
      {required this.bemVindoContainerHeight,
      required this.displayBemVindoContainer});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: AnimatedSize(
        duration: Duration(milliseconds: 160),
        curve: Curves.bounceIn,
        child: Container(
          height: bemVindoContainerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 16.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CabecalhoCadastro(
                    mostraProgressao: false,
                    subTitulo: 'E qual é o destino à seguir agora?',
                    titulo: 'Pronto vamos lá',
                    indiceProgressao: 1,
                    retornoClicked: () {}),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: SizedBox(
                    child: Center(
                      child: Image.asset(
                        'assets/images/home1Ok.png',
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 50,
                  child:
                      Expanded(
                        child: ElevatedButton(
                            onPressed: (){},
                            child: Text("COMEÇAR")),
                      ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
