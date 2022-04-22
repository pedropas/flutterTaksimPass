import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';

import '../../DataHandler/appData.dart';
import '../../componentes/divider_widget.dart';
import '../search/searchScreen.dart';

class CustonPositionEsperaMotoristaConfirmacao extends StatefulWidget {
  const CustonPositionEsperaMotoristaConfirmacao(
      {Key? key,
      required this.displayEsperaMotoristaConfirmacaoContainer,
        required this.cancelaEsperaMotoristaConfirmacaoContainer,
      required this.motoristaId,})
      : super(key: key);

  final VoidCallback displayEsperaMotoristaConfirmacaoContainer;
  final VoidCallback cancelaEsperaMotoristaConfirmacaoContainer;
  final int motoristaId;

  @override
  _CustonPositionEsperaMotoristaConfirmacaoState createState() =>
      _CustonPositionEsperaMotoristaConfirmacaoState(
        displayEsperaMotoristaConfirmacaoContainer:
            displayEsperaMotoristaConfirmacaoContainer,
        cancelaEsperaMotoristaConfirmacaoContainer: cancelaEsperaMotoristaConfirmacaoContainer,
        motoristaId: motoristaId,
      );
}

class _CustonPositionEsperaMotoristaConfirmacaoState
    extends State<CustonPositionEsperaMotoristaConfirmacao> {
  double EsperaMotoristaConfirmacaoContainerHeight = 370;
  VoidCallback displayEsperaMotoristaConfirmacaoContainer;
  VoidCallback cancelaEsperaMotoristaConfirmacaoContainer;
  final int motoristaId;

  _CustonPositionEsperaMotoristaConfirmacaoState({
    required this.displayEsperaMotoristaConfirmacaoContainer,
    required this.cancelaEsperaMotoristaConfirmacaoContainer,
    required this.motoristaId,
  });

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
          height: EsperaMotoristaConfirmacaoContainerHeight,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade300,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            boxShadow: const [
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
                  subTitulo:
                      'Estamos aguardando a confirmação do seu motorista',
                  titulo: 'Táxi localizado',
                  indiceProgressao: 1,
                  retornoClicked: () {},
                  mostrarBotaoRetorno: false,
                ),
                const SizedBox(
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
                  child: ElevatedButton(
                      onPressed: cancelaEsperaMotoristaConfirmacaoContainer,
                      child: Text("CANCELAR"),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.transparent,
                      shadowColor: Colors.black,
                      side: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
