import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taksim/helpers/config_screen.dart';

class Apresentacao extends StatelessWidget {
  String titulo;
  String texto;
  String imagemPath;
  VoidCallback proximaPagina;
  VoidCallback paginaFinal;
  bool pularFinal;

  Apresentacao(
      {required this.titulo,
      required this.texto,
      required this.imagemPath,
      required this.proximaPagina,
      required this.paginaFinal,
      required this.pularFinal});

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Splash3Widget - FRAME
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Container(
                  child:
                      Image.asset(imagemPath, height: 250, fit: BoxFit.contain),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  titulo,
                  style: TextStyle(
                      fontFamily: "Montserrat Bold",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: FONT_COLOR),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  texto,
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: paginaFinal,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text(
                        pularFinal ? "Pular" : "Próximo",
                        style: TextStyle(color: FONT_COLOR, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  (pularFinal
                      ? ElevatedButton(
                          onPressed: pularFinal ? proximaPagina : null,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            side: BorderSide(
                              width: 1,
                              color: Colors.transparent,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.arrowAltCircleRight,
                            color: Colors.black26,
                            size: 40,
                          ),
                        )
                      : Container()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
