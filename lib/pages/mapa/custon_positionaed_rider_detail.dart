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

class CustonPositionedRiderDetail extends StatefulWidget {
  const CustonPositionedRiderDetail(
      {Key? key, required this.displayRequestRideContainer})
      : super(key: key);

  final Function displayRequestRideContainer;

  @override
  _CustonPositionedRiderDetailState createState() =>
      _CustonPositionedRiderDetailState(
          displayRequestRideContainer: displayRequestRideContainer);
}

class _CustonPositionedRiderDetailState
    extends State<CustonPositionedRiderDetail> {
  double riderDetailContainerHeight = 390;
  late Function displayRequestRideContainer;
  late DirectionDetails tripDirectionDetails = DirectionDetails();

  _CustonPositionedRiderDetailState(
      {required this.displayRequestRideContainer});

  List<EntFrota> listOfVeiculo = [
    EntFrota(
      nomeFrota: 'Frota',
      tempoEstimado: '10 min',
      distanciaEstimado: '15,00',
      placaModelo: 'ABC1A234',
      veiculoImagem: 'assets/images/taxi.png',
      latitude: 0,
      longitude: 0,
      motoristaId: 1,
      percentualDesconto: 0,
    ),
    EntFrota(
      nomeFrota: 'Frota 2',
      tempoEstimado: '12 min',
      distanciaEstimado: 'R 12,00',
      placaModelo: 'ABC1B124',
      veiculoImagem: 'assets/images/taxi.png',
      latitude: 0,
      longitude: 0,
      motoristaId: 1,
      percentualDesconto: 0,
    ),
    EntFrota(
      nomeFrota: 'Frota 3',
      tempoEstimado: '12 min',
      distanciaEstimado: 'R 12,00',
      placaModelo: 'ABC1B155',
      veiculoImagem: 'assets/images/taxi.png',
      latitude: 0,
      longitude: 0,
      motoristaId: 1,
      percentualDesconto: 0,
    ),
    EntFrota(
      nomeFrota: 'Frota 4',
      tempoEstimado: '12 min',
      distanciaEstimado: 'R 12,00',
      placaModelo: 'ABC1B155',
      veiculoImagem: 'assets/images/taxi.png',
      latitude: 0,
      longitude: 0,
      motoristaId: 1,
      percentualDesconto: 0,
    ),
  ];

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
                children: <Widget>[
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
              SizedBox(height: 15,),
              SizedBox(
                height: 190,
                child: ListView.builder(
                    itemCount: listOfVeiculo.length,
                    itemBuilder: (context, index) {
                      return ItemVeiculo(listOfVeiculo[index]);
                    }),
              ),
              Divider(
                height: 10.0,
                color: Colors.grey.shade300,
                thickness: 5.0,
              ),
              SizedBox(height: 5,),
              Row(
                children: <Widget>[
                  CustomIconButton(
                      radius: 5,
                      iconData: FontAwesomeIcons.minus,
                      onTap: () {}),
                  SizedBox(
                    width: 10,
                  ),
                  Text("20 %",
                      style: TextStyle(
                          color: BUTTON_COLOR,
                          fontSize: 20,
                          fontFamily: "Montserrat Bold")),
                  SizedBox(
                    width: 10,
                  ),
                  CustomIconButton(
                      radius: 5, iconData: FontAwesomeIcons.plus, onTap: () {}),
                  SizedBox(
                    width: 110,
                  ),
                  Icon(
                    Icons.payment,
                    color: BUTTON_COLOR,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Adicionar",
                    style: TextStyle(
                        color: BUTTON_COLOR,
                        fontSize: 15,
                        fontFamily: "Montserrat Bold"),
                  ),
                  CustomIconButton(
                      radius: 5,
                      iconData: FontAwesomeIcons.arrowAltCircleRight,
                      onTap: () {}),
                ],
              ),
              CustomComboBox(
                label: '',
                selectedValue: (_) {},
                listColor: Colors.deepPurple.shade50,
                listItens: ['Dinheiro', 'Cartão Crédito', 'Cartão Débito'],
                hintText: 'Teste',
                valorEscolhido: 'Dinheiro',
              ),
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
