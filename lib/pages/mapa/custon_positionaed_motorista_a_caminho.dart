import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/dominio/ent_motorista.dart';
import 'package:taksim/helpers/config_screen.dart';
import '../../componentes/image_icon_custon.dart';

class CustonPositionMotoristaACaminho extends StatefulWidget {
  const CustonPositionMotoristaACaminho({
    Key? key,
    required this.displayMotoristaACaminhoContainer,
    required this.cancelaMotoristaACaminhoContainer,
    required this.motorista,
    required this.percentualDesconto,
  }) : super(key: key);

  final VoidCallback displayMotoristaACaminhoContainer;
  final VoidCallback cancelaMotoristaACaminhoContainer;
  final EntMotorista motorista;
  final int percentualDesconto;

  @override
  _CustonPositionMotoristaACaminhoState createState() =>
      _CustonPositionMotoristaACaminhoState(
        displayMotoristaACaminhoContainer: displayMotoristaACaminhoContainer,
        cancelaMotoristaACaminhoContainer: cancelaMotoristaACaminhoContainer,
        motorista: motorista,
        percentualDesconto: percentualDesconto,
      );
}

class _CustonPositionMotoristaACaminhoState
    extends State<CustonPositionMotoristaACaminho> {
  double MotoristaACaminhoContainerHeight = 370;
  VoidCallback displayMotoristaACaminhoContainer;
  VoidCallback cancelaMotoristaACaminhoContainer;
  EntMotorista motorista;
  int percentualDesconto = 0;

  _CustonPositionMotoristaACaminhoState({
    required this.displayMotoristaACaminhoContainer,
    required this.cancelaMotoristaACaminhoContainer,
    required this.motorista,
    required this.percentualDesconto,
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
          height: MotoristaACaminhoContainerHeight,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade400,
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
                  subTitulo: '',
                  titulo: 'Estou a caminho',
                  indiceProgressao: 1,
                  retornoClicked: () {},
                  mostrarBotaoRetorno: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: SizedBox(
                    height: 90,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18.0),
                            bottomRight: Radius.circular(18.0)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Container(
                              child: ImageIconCuston(
                                imageB64: motorista.getImageFoto(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    motorista.nome,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      motorista.avaliacao.toStringAsFixed(2),
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
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
                            width: 100,
                            height: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade100,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(18.0)),
                              ),
                              child: Center(
                                child: Text(
                                  "$percentualDesconto %",
                                  style: const TextStyle(
                                      fontSize: 30, color: BUTTON_COLOR),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SizedBox(
                    height: 100,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            topRight: Radius.circular(18.0)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                height: 20,
                                child: Text(
                                  "12 km - Distância",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              SizedBox(
                                height: 20,
                                child: Text(
                                  "21 min - Chegada",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 310,
                            child: Center(
                              child: Row(
                                children: [
                                  //Homem
                                  const SizedBox(
                                    height: 20,
                                    child: Text(
                                      "Homem ",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: motorista.sexo == 1
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 20,
                                          )
                                        : const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  // adaptado
                                  const SizedBox(
                                    height: 20,
                                    child: Text(
                                      "Adaptado ",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: motorista.aptoCego
                                        ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    )
                                        : const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  // bagagem
                                  const SizedBox(
                                    height: 20,
                                    child: Text(
                                      "Bagagem Extra ",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                              Container(
                                child: false
                                    ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 20,
                                )
                                    : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: cancelaMotoristaACaminhoContainer,
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
