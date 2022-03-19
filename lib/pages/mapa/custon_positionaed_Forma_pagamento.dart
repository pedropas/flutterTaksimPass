import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/helpers/config_screen.dart';

import '../../DataHandler/appData.dart';
import '../../componentes/divider_widget.dart';
import '../search/searchScreen.dart';

class CustonPositionEscolherFormaPagamento extends StatefulWidget {
  const CustonPositionEscolherFormaPagamento(
      {Key? key, required this.onEscolherFormaPagamentoClicked,
      required this.onCancelarFormaPagamentoClicked,})
      : super(key: key);

  final VoidCallback onEscolherFormaPagamentoClicked;
  final VoidCallback onCancelarFormaPagamentoClicked;
  @override
  _CustonPositionEscolherFormaPagamentoState createState() =>
      _CustonPositionEscolherFormaPagamentoState(
          onEscolherFormaPagamentoClicked: onEscolherFormaPagamentoClicked,
      onCancelarFormaPagamentoClicked: onCancelarFormaPagamentoClicked,);
}

class _CustonPositionEscolherFormaPagamentoState
    extends State<CustonPositionEscolherFormaPagamento> {
  double FormaPagamentoContainerHeight = 380;
  VoidCallback onEscolherFormaPagamentoClicked;
  VoidCallback onCancelarFormaPagamentoClicked;

  _CustonPositionEscolherFormaPagamentoState(
      {required this.onEscolherFormaPagamentoClicked,
        required this.onCancelarFormaPagamentoClicked,});

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
          height: FormaPagamentoContainerHeight,
          decoration: const BoxDecoration(
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
                    subTitulo:
                        'Escolha a melhor maneira para efetuar o pagamento.',
                    titulo: 'Método de pagamento',
                    indiceProgressao: 1,
                    retornoClicked: () {},
                mostrarBotaoRetorno: false,),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: SizedBox(
                    child: Center(
                      child: Image.asset(
                        'assets/images/MetodoPagamento.png',
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onCancelarFormaPagamentoClicked,
                          child: Text("CANCELAR", style: TextStyle(color: BUTTON_COLOR),),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            side: const BorderSide(
                              width: 1,
                              color: BUTTON_COLOR,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onEscolherFormaPagamentoClicked,
                          child: Text("ESCOLHER", style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: BUTTON_COLOR,
                            shadowColor: Colors.transparent,
                            side: const BorderSide(
                              width: 1,
                              color: BUTTON_COLOR,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
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
