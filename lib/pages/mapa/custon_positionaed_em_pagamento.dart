import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taksim/dominio/EntDataModel1.dart';
import 'package:taksim/dominio/ent_motorista.dart';
import 'package:taksim/helpers/config_screen.dart';
import '../../componentes/image_icon_custon.dart';
import '../../dominio/badget_custom.dart';
import '../../dominio/directDetails.dart';
import 'blocs/motorista_bloc.dart';

class CustonPositionEmPagamento extends StatefulWidget {
  const CustonPositionEmPagamento({
    Key? key,
    required this.displayEmPagamentoContainer,
    required this.cancelaEmPagamentoContainer,
    required this.motorista,
    required this.percentualDesconto,
    required this.motoristaBloc,
  }) : super(key: key);

  final VoidCallback displayEmPagamentoContainer;
  final VoidCallback cancelaEmPagamentoContainer;
  final EntMotorista motorista;
  final int percentualDesconto;
  final MotoristaBloc motoristaBloc;

  @override
  _CustonPositionEmPagamentoState createState() => _CustonPositionEmPagamentoState(
        displayEmPagamentoContainer: displayEmPagamentoContainer,
        cancelaEmPagamentoContainer: cancelaEmPagamentoContainer,
        motorista: motorista,
        percentualDesconto: percentualDesconto,
        motoristaBloc: motoristaBloc,
      );
}

class _CustonPositionEmPagamentoState extends State<CustonPositionEmPagamento> {
  double EmPagamentoContainerHeight = 450;
  VoidCallback displayEmPagamentoContainer;
  VoidCallback cancelaEmPagamentoContainer;
  EntMotorista motorista;
  int percentualDesconto = 0;
  MotoristaBloc motoristaBloc;

  _CustonPositionEmPagamentoState({
    required this.displayEmPagamentoContainer,
    required this.cancelaEmPagamentoContainer,
    required this.motorista,
    required this.percentualDesconto,
    required this.motoristaBloc,
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
          height: EmPagamentoContainerHeight,
          decoration: const BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
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
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 90,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0),
                          ),
                        ),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Container(
                            child: StreamBuilder<BadgetCustom>(
                                stream: motoristaBloc.outBadgetPosicao,
                                builder: (context, snapshot) {
                                  String tPosicao = "I";
                                  Color cFont = Colors.white;
                                  Color cBack = Colors.white;
                                  if ((snapshot != null)
                                      && (snapshot.data != null)) {
                                    tPosicao = snapshot.data!.text;
                                    cFont = snapshot.data!.textColor;
                                    cBack = snapshot.data!.color;
                                  }
                                  return Badge(
                                    badgeContent: Text(tPosicao, style: TextStyle(fontSize: 10, color: cFont),),
                                    badgeColor: cBack,
                                    position: BadgePosition.bottomEnd(),
                                    child: ImageIconCuston(
                                      imageB64: motorista.getImageFoto(),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: StreamBuilder<String>(
                            stream: motoristaBloc.outTempoViagem,
                            builder: (context, snapshot) {
                              String tempo = snapshot.data ?? "00:00";
                              return Text(
                                "Tempo de viagem: $tempo",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: "Montserrat Bold",
                                ),
                              );
                            }
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 26,
                          width: 330,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 170,
                                child: Text(
                                  motorista.nome,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat Bold",
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 60,
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      margin: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 235, 235, 235),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Text(
                                        motorista.avaliacao.toStringAsFixed(2),
                                        style: const TextStyle(
                                          color: BUTTON_COLOR,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat Bold",
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   motorista.avaliacao.toStringAsFixed(2),
                                  //   style: const TextStyle(
                                  //     fontSize: 18,
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: motorista.avaliacao >= 1
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: motorista.avaliacao >= 2
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: motorista.avaliacao >= 3
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: motorista.avaliacao >= 4
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: motorista.avaliacao >= 5
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 90,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.emergency,
                              color: Colors.red,
                              size: 40,
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.transparent,
                              shadowColor: Colors.black,
                              side: const BorderSide(
                                width: 1,
                                color: Colors.red,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 90,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.share,
                              color: Colors.blue,
                              size: 40,
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.transparent,
                              shadowColor: Colors.black,
                              side: const BorderSide(
                                width: 1,
                                color: Colors.blue,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder<EntDataModel1>(
                  stream: motoristaBloc.outDataModel1,
                  builder: (context, snapshot) {
                    String vTax =  "R\$ 0,00";
                    String vPagar =  "R\$ 0,00";
                    if ((snapshot != null) && (snapshot.data != null)) {
                      vTax = "R\$ " + (snapshot.data!.price/100).toStringAsFixed(2);
                      vPagar = "R\$ " + (snapshot.data!.valorComDesconto/100).toStringAsFixed(2);
                    }
                    return Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Container(
                            color: Colors.grey.shade100,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Tarifa Taxímetro",
                                    style: TextStyle(fontSize: 15, color: BUTTON_COLOR),
                                  ),
                                  Text(vTax,
                                    style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Container(
                            color: Colors.deepPurple.shade100,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Tarifa Viagem",
                                    style: TextStyle(fontSize: 15, color: BUTTON_COLOR),
                                  ),
                                  Text(vPagar,
                                    style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
