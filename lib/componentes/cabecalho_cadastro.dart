import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:taksim/helpers/config_screen.dart';

class CabecalhoCadastro extends StatelessWidget {
  bool mostraProgressao;
  String titulo;
  String subTitulo;
  int indiceProgressao;
  VoidCallback retornoClicked;

  CabecalhoCadastro({
    required this.mostraProgressao,
    required this.subTitulo,
    required this.titulo,
    required this.indiceProgressao,
    required this.retornoClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 120,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: mostraProgressao
                    ? OutlinedButton(
                        onPressed: retornoClicked,
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: BUTTON_COLOR,
                          size: 26,
                        ),
                      )
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: mostraProgressao
                    ? ProgressStepper(
                        width: 200,
                        height: 5,
                        color: Colors.grey,
                        stepCount: 6,
                        currentStep: indiceProgressao,
                        progressColor: BUTTON_COLOR,
                      )
                    : null,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            titulo,
            style: TextStyle(
                fontFamily: "Montserrat Bold",
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Text(
                subTitulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      //),
    );
  }
}
