import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taksim/dominio/ent_motorista.dart';
import 'package:taksim/helpers/config_screen.dart';
import '../../componentes/image_icon_custon.dart';
import '../../dominio/directDetails.dart';
import 'blocs/motorista_bloc.dart';

class CustonPositionEmCorrida extends StatefulWidget {
  const CustonPositionEmCorrida({
    Key? key,
    required this.displayEmCorridaContainer,
    required this.cancelaEmCorridaContainer,
    required this.motorista,
    required this.percentualDesconto,
    required this.motoristaBloc,
  }) : super(key: key);

  final VoidCallback displayEmCorridaContainer;
  final VoidCallback cancelaEmCorridaContainer;
  final EntMotorista motorista;
  final int percentualDesconto;
  final MotoristaBloc motoristaBloc;

  @override
  _CustonPositionEmCorridaState createState() => _CustonPositionEmCorridaState(
        displayEmCorridaContainer: displayEmCorridaContainer,
        cancelaEmCorridaContainer: cancelaEmCorridaContainer,
        motorista: motorista,
        percentualDesconto: percentualDesconto,
        motoristaBloc: motoristaBloc,
      );
}

class _CustonPositionEmCorridaState extends State<CustonPositionEmCorrida> {
  double EmCorridaContainerHeight = 250;
  VoidCallback displayEmCorridaContainer;
  VoidCallback cancelaEmCorridaContainer;
  EntMotorista motorista;
  int percentualDesconto = 0;
  MotoristaBloc motoristaBloc;

  _CustonPositionEmCorridaState({
    required this.displayEmCorridaContainer,
    required this.cancelaEmCorridaContainer,
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
          height: EmCorridaContainerHeight,
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
                            child: ImageIconCuston(
                                  imageB64: motorista.getImageFoto(),
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
                          child: Text(
                            "Tempo de viagem: 00:00",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Montserrat Bold",
                            ),
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
                              SizedBox(
                                height: 50,
                                width: 70,
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
                                    motorista.avaliacao.toString(),
                                    style: const TextStyle(
                                      color: BUTTON_COLOR,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat Bold",
                                    ),
                                  ),
                                ),
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
                            child: Icon(
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
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 90,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Icon(
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
                Row(
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
                              Text("R\$ 2.75",
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
                              Text("R\$ 2.75",
                                style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
