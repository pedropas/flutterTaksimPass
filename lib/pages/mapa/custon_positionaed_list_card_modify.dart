import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/dominio/ent_cartao_passageiro.dart';
import 'package:taksim/helpers/config_screen.dart';

import '../../DataHandler/appData.dart';
import '../../componentes/divider_widget.dart';
import '../../helpers/config-gerais.dart';
import '../search/searchScreen.dart';
import 'blocs/cartoespassageiro_bloc.dart';
import 'blocs/formaPagamento_bloc.dart';

class CustonPositionEscolherListaCartaoModifica extends StatefulWidget {
  const CustonPositionEscolherListaCartaoModifica({
    Key? key,
    required this.onEscolherFormaPagamentOpcaoClicked,
    required this.onCancelarFormaPagamentoOpcaoClicked,
    required this.onAddCardOrModify,
  }) : super(key: key);

  final Function(int) onEscolherFormaPagamentOpcaoClicked;
  final VoidCallback onCancelarFormaPagamentoOpcaoClicked;
  final VoidCallback onAddCardOrModify;

  @override
  _CustonPositionEscolherListaCartaoModificaState createState() =>
      _CustonPositionEscolherListaCartaoModificaState(
        onEscolherCartaoClicked: onEscolherFormaPagamentOpcaoClicked,
        onCancelarEcolhaCartaoClicked: onCancelarFormaPagamentoOpcaoClicked,
        onAddCardOrModify: onAddCardOrModify,
      );
}

class _CustonPositionEscolherListaCartaoModificaState
    extends State<CustonPositionEscolherListaCartaoModifica> {
  CartoesPassageiroBloc cartoesPassageiroBloc = CartoesPassageiroBloc();
  double ListofCartoesContainerHeight = 500;
  Function(int) onEscolherCartaoClicked;
  VoidCallback onCancelarEcolhaCartaoClicked;
  VoidCallback onAddCardOrModify;

  _CustonPositionEscolherListaCartaoModificaState({
    required this.onEscolherCartaoClicked,
    required this.onCancelarEcolhaCartaoClicked,
    required this.onAddCardOrModify,
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
          height: ListofCartoesContainerHeight,
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
                        onTap: onCancelarEcolhaCartaoClicked,
                        child: const Icon(
                          FontAwesomeIcons.arrowLeft,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Expanded(
                        child: Text(
                          'Cadastro/Modificação de cartão',
                          style: TextStyle(
                            fontFamily: "Montserrat Bold",
                            fontSize: 20,
                            color: BUTTON_COLOR,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 340,
                  child: StreamBuilder<List<EntCartaoPassageiro>>(
                      stream: cartoesPassageiroBloc.listOfCartaoPassageiro,
                      initialData: [
                        EntCartaoPassageiro(
                          passageiroId: 1,
                          quatroUltimosCartao: 0000,
                          brand: 'OUTROS',
                        )
                      ],
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            String img =
                                CARD_BRAND[snapshot.data![index].brand] ??
                                    'assets/images/outrocard.png';
                            String cartao = snapshot
                                .data![index].quatroUltimosCartao
                                .toString();
                            cartao = '****.****.****.' + cartao;
                            return Column(
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                    img,
                                    width: 30,
                                    height: 30,
                                  ),
                                  subtitle:
                                      Text(snapshot.data![index].brand ?? ''),
                                  title: Text(cartao),
                                  iconColor: BUTTON_COLOR,
                                  textColor: Colors.black,
                                  selectedColor: Colors.green,
                                  selected: snapshot.data![index].status,
                                  trailing: snapshot.data![index].status
                                      ? const Icon(
                                          FontAwesomeIcons.check,
                                          size: 20,
                                        )
                                      : null,
                                  onTap: () {},
                                ),
                                const Divider(
                                  height: 2.0,
                                  thickness: 2,
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ),
                ElevatedButton(
                  onPressed: onAddCardOrModify,
                  child: Row(
                    children: const [
                      Text("Adicionar cartâo"),
                      SizedBox(
                        width: 205,
                      ),
                      Icon(
                        FontAwesomeIcons.plus,
                        size: 20,
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
