import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/helpers/config_screen.dart';

import '../../DataHandler/appData.dart';
import '../../componentes/divider_widget.dart';
import '../../helpers/config-gerais.dart';
import '../search/searchScreen.dart';
import 'blocs/formaPagamento_bloc.dart';

class CustonPositionEscolherFormaPagamentOpcao extends StatefulWidget {
  const CustonPositionEscolherFormaPagamentOpcao({
    Key? key,
    required this.onEscolherFormaPagamentOpcaoClicked,
    required this.onCancelarFormaPagamentoOpcaoClicked,
  }) : super(key: key);

  final Function(int) onEscolherFormaPagamentOpcaoClicked;
  final VoidCallback onCancelarFormaPagamentoOpcaoClicked;

  @override
  _CustonPositionEscolherFormaPagamentOpcaoState createState() =>
      _CustonPositionEscolherFormaPagamentOpcaoState(
        onEscolherFormaPagamentOpcaoClicked:
            onEscolherFormaPagamentOpcaoClicked,
        onCancelarFormaPagamentoOpcaoClicked:
            onCancelarFormaPagamentoOpcaoClicked,
      );
}

class _CustonPositionEscolherFormaPagamentOpcaoState
    extends State<CustonPositionEscolherFormaPagamentOpcao> {
  FormaPagamentoBloc formaPagamentoBloc = FormaPagamentoBloc();
  double FormaPagamentoContainerHeight = 500;
  Function(int) onEscolherFormaPagamentOpcaoClicked;
  VoidCallback onCancelarFormaPagamentoOpcaoClicked;

  _CustonPositionEscolherFormaPagamentOpcaoState({
    required this.onEscolherFormaPagamentOpcaoClicked,
    required this.onCancelarFormaPagamentoOpcaoClicked,
  });

  @override
  Widget build(BuildContext context) {
    int valorSelecionado = 0;

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
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: onCancelarFormaPagamentoOpcaoClicked,
                        child: const Icon(
                          FontAwesomeIcons.arrowLeft,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'Método de pagamento',
                        style: TextStyle(
                          fontFamily: "Montserrat Bold",
                          fontSize: 20,
                          color: BUTTON_COLOR,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 360,
                  child: StreamBuilder<int>(
                      stream: formaPagamentoBloc.formaPagamentoPreferencial,
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemCount: FORMA_PAGAMENTO_ICONE.length,
                          itemBuilder: (context, index) {
                            String key =
                                FORMA_PAGAMENTO_ICONE.keys.elementAt(index);
                            return Column(
                              children: [
                                ListTile(
                                  leading: Icon(FORMA_PAGAMENTO_ICONE[key]),
                                  title: Text(key),
                                  iconColor: BUTTON_COLOR,
                                  textColor: Colors.black,
                                  selectedColor: Colors.green,
                                  selected: (index == snapshot.data),
                                  onTap: () {
                                    formaPagamentoBloc.setFormaPagamentoIndice(index);
                                  },
                                ),
                                Divider(
                                  height: 2.0,
                                  thickness: 2,
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
