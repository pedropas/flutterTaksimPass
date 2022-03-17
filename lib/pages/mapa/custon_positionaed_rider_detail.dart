import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taksim/componentes/drawer/custom_icon_button.dart';
import 'package:taksim/dominio/ent_frota.dart';
import 'package:taksim/helpers/config_screen.dart';
import 'package:taksim/pages/mapa/list/itemListVeiculo.dart';

import '../../DataHandler/appData.dart';
import '../../assistants/assistantMethods.dart';
import '../../componentes/custom_combobox.dart';
import '../../componentes/divider_widget.dart';
import '../../dominio/directDetails.dart';
import '../search/searchScreen.dart';
import 'blocs/frota_bloc.dart';

class CustonPositionedRiderDetail extends StatefulWidget {
  const CustonPositionedRiderDetail(
      {Key? key,
      required this.displayRequestRideContainer,
      required this.listOfVeiculo})
      : super(key: key);

  final Function displayRequestRideContainer;
  final List<EntFrota> listOfVeiculo;

  @override
  _CustonPositionedRiderDetailState createState() =>
      _CustonPositionedRiderDetailState(
          displayRequestRideContainer: displayRequestRideContainer,
          listOfVeiculo: listOfVeiculo);
}

class _CustonPositionedRiderDetailState
    extends State<CustonPositionedRiderDetail> {
  double riderDetailContainerHeight = 390;
  late Function displayRequestRideContainer;
  DirectionDetails tripDirectionDetails = DirectionDetails();
  final List<EntFrota> listOfVeiculo;

  _CustonPositionedRiderDetailState(
      {required this.displayRequestRideContainer, required this.listOfVeiculo});

  final _frotaBloc = FrotaBloc();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: AnimatedSize(
        duration: Duration(milliseconds: 160),
        curve: Curves.bounceIn,
        child: Container(
          height: riderDetailContainerHeight,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 16.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              )
            ],
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Text("Preferência",
                      style: TextStyle(
                          color: BUTTON_COLOR,
                          fontSize: 15,
                          fontFamily: "Montserrat Bold")),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.mode_edit,
                    color: BUTTON_COLOR,
                  ),
                  SizedBox(
                    width: 120,
                  ),
                  Text("Agendar",
                      style: TextStyle(
                          color: BUTTON_COLOR,
                          fontSize: 15,
                          fontFamily: "Montserrat Bold")),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: BUTTON_COLOR,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder<List>(
                  stream: _frotaBloc.outFrotas,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox(
                        height: 250,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(Colors.deepPurple),
                          ),
                        ),
                      );
                    } else if (snapshot.data?.length == 0) {
                      return const SizedBox(
                        height: 250,
                        child: Center(
                          child: Text("Nenhum veiculo encontrado!"),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return ItemVeiculo(snapshot.data?[index]);
                          },
                        ),
                      );
                    }
                  }),
              Divider(
                height: 5.0,
                color: Colors.grey.shade300,
                thickness: 5.0,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  // botão decrementa percentual
                  SizedBox(
                    width: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.deepPurple.shade50,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _frotaBloc.onDecrementaClicked,
                      child: Icon(
                        FontAwesomeIcons.minus,
                        color: Colors.deepPurple,
                        size: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  StreamBuilder<double>(
                      stream: _frotaBloc.outPercentualDesconto,
                      builder: (context, snapshot) {
                        return Text(snapshot.data.toString(),
                            style: TextStyle(
                                color: BUTTON_COLOR,
                                fontSize: 20,
                                fontFamily: "Montserrat Bold"));
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  // botao incrementa percentual
                  SizedBox(
                    width: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.deepPurple.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _frotaBloc.onIncrementaClicked,
                      child: Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.deepPurple,
                        size: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 45,
                  ),
                  // icone de forma de pagamento
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    child: StreamBuilder<IconData>(
                      stream: _frotaBloc.outIconFormaPagamento,
                      builder: (context, snapshot) {
                        return Icon(snapshot.data,
                          size: 35,
                          color: BUTTON_COLOR,
                        );
                      }
                    ),
                  ),
                  StreamBuilder<String>(
                    stream: _frotaBloc.outFormaPagamento,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: 100,
                        child: Expanded(
                          child: Text(
                            snapshot.data ?? 'Dinheiro',
                            style: const TextStyle(
                                color: BUTTON_COLOR,
                                fontSize: 15,
                                fontFamily: "Montserrat Bold"),
                          ),
                        ),
                      );
                    }
                  ),
                  // texto forma pagamento
                  const SizedBox(
                    width: 5,
                  ),
                  // icone
                  CustomIconButton(
                      radius: 5,
                      iconData: FontAwesomeIcons.arrowAltCircleRight,
                      onTap: () {}),
                ],
              ),
              // CustomComboBox(
              //   label: '',
              //   selectedValue: (_) {},
              //   listColor: Colors.deepPurple.shade50,
              //   listItens: ['Dinheiro', 'Cartão Crédito', 'Cartão Débito'],
              //   hintText: 'Teste',
              //   valorEscolhido: 'Dinheiro',
              // ),
            ],
          ),
          // child: Column(
          //   children: [
          //     Container(
          //       width: double.infinity,
          //       color: Colors.white,
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(
          //           horizontal: 16.0,
          //         ),
          //         child: Row(
          //           children: [
          //             Image.asset(
          //               "assets/images/taxi.png",
          //               height: 70.0,
          //               width: 80,
          //             ),
          //             SizedBox(
          //               width: 16.0,
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(
          //                 vertical: 17.0,
          //               ),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Carro:",
          //                     style: TextStyle(
          //                       fontSize: 18.0,
          //                       fontFamily: "Brand Bold",
          //                     ),
          //                   ),
          //                   Text(
          //                     (tripDirectionDetails != null)
          //                         ? tripDirectionDetails.distanceText
          //                         : '',
          //                     style: TextStyle(
          //                       fontSize: 18.0,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Expanded(
          //               child: Container(),
          //             ),
          //             Text(
          //               (tripDirectionDetails != null)
          //                   ? 'R\$ ${AssistantMethods.calculateFares(tripDirectionDetails)}'
          //                   : '',
          //               style: TextStyle(
          //                 fontSize: 18.0,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 20.0,
          //     ),
          //     Padding(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: 20.0,
          //       ),
          //       child: Row(
          //         children: [
          //           Icon(
          //             FontAwesomeIcons.moneyCheckAlt,
          //             size: 18,
          //             color: Colors.black54,
          //           ),
          //           SizedBox(
          //             width: 16.0,
          //           ),
          //           Text('Dinheiro'),
          //           SizedBox(
          //             width: 6.0,
          //           ),
          //           Icon(
          //             Icons.keyboard_arrow_down,
          //             color: Colors.black54,
          //             size: 16.0,
          //           ),
          //         ],
          //       ),
          //     ),
          //     SizedBox(height: 20.0),
          //     Padding(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: 16.0,
          //       ),
          //       child: ElevatedButton(
          //         onPressed: () {
          //           displayRequestRideContainer();
          //         },
          //         child: Padding(
          //           padding: EdgeInsets.all(17.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 "Solicitar",
          //                 style: TextStyle(
          //                   fontSize: 20.0,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //               Icon(
          //                 FontAwesomeIcons.taxi,
          //                 color: Colors.white,
          //                 size: 16,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
