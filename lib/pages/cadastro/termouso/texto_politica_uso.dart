import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/helpers/config_screen.dart';

import '../../../componentes/button_flag.dart';
import '../../base/page_store.dart';

class TextoPoliticaUso extends StatefulWidget {
  const TextoPoliticaUso({Key? key}) : super(key: key);

  @override
  State<TextoPoliticaUso> createState() => _TextoPoliticaUsoState();
}

class _TextoPoliticaUsoState extends State<TextoPoliticaUso> {
  late SharedPreferences sharedPreferences;

  bool mostrarAceite = true;

  Future<SharedPreferences> getSharedP() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  Future<String> getTextoTermoUso() async {
    return "teste";
  }

  @override
  void initState() {
    super.initState();
    getSharedP().then((value) {
      sharedPreferences = value;
      if (sharedPreferences.getBool(KEY_POLITICA_USO) != null)
      {
        mostrarAceite = sharedPreferences.getBool(KEY_POLITICA_USO) ?? true;
        setState(() {
          mostrarAceite = !mostrarAceite;
        });
      }
    });
    getTextoTermoUso().then((value) {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            CabecalhoCadastro(
                indiceProgressao: 2,
                mostraProgressao: true,
                titulo: "Politica de uso",
                subTitulo:
                    "Leia com atenção todo o termo e clique em aceitar para continuar.",
                retornoClicked: onButtonBackClick),
            SizedBox(height: 5,),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child: Text.rich(
                          TextSpan(
                            text: getTexto(),
                            children: <InlineSpan>[
                              TextSpan(
                                text: getTexto(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
              ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * .90,
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: mostrarAceite ? () {
                      onTermoUsoSelecionado();
                      onButtonBackClick();
                    } : null,
                    child: Text(
                      "ACEITAR",
                      style: TextStyle(
                        fontFamily: "Montserrat Bold",
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }

  void onButtonBackClick() {
    GetIt.I<PageStore>().setPage(INDICE_TELA_TERMO_USO);
  }

  void onTermoUsoSelecionado() {
    sharedPreferences.setBool(KEY_POLITICA_USO, true);
  }

  String getTexto() {
    return "dfgsdfgsdfgsdf sdfg"
        "sdfgsdfgd"
        "dsfgsdfgsd"
        "sdfgdsfgsdfg"
        "dfgsdfgdfg"
        "sdfgsdfgsdfg"
        "sdfgdsfgsdfg"
        "sdfgsdfgsdf"
        "sdfgsdfgdsfgsdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsd fsdfgsdfgsdfgdfgsdfg"
        "sdfgdfgsdfgsdfgsdfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsddfgfg"
        "dfgsdfgsdfgsdf sdfg"
        "sdfgsdfgd"
        "dsfgsdfgsd"
        "sdfgdsfgsdfg"
        "dfgsdfgdfg"
        "sdfgsdfgsdfg"
        "sdfgdsfgsdfg"
        "sdfgsdfgsdf"
        "sdfgsdfgdsfgsdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsd fsdfgsdfgsdfgdfgsdfg"
        "sdfgdfgsdfgsdfgsdfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsddfgfg"
        "dfgsdfgsdfgsdf sdfg"
        "sdfgsdfgd"
        "dsfgsdfgsd"
        "sdfgdsfgsdfg"
        "dfgsdfgdfg"
        "sdfgsdfgsdfg"
        "sdfgdsfgsdfg"
        "sdfgsdfgsdf"
        "sdfgsdfgdsfgsdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsd fsdfgsdfgsdfgdfgsdfg"
        "sdfgdfgsdfgsdfgsdfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsddfgfg"
        "dfgsdfgsdfgsdf sdfg"
        "sdfgsdfgd"
        "dsfgsdfgsd"
        "sdfgdsfgsdfg"
        "dfgsdfgdfg"
        "sdfgsdfgsdfg"
        "sdfgdsfgsdfg"
        "sdfgsdfgsdf"
        "sdfgsdfgdsfgsdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsd fsdfgsdfgsdfgdfgsdfg"
        "sdfgdfgsdfgsdfgsdfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsddfgfg"
        "dfgsdfgsdfgsdf sdfg"
        "sdfgsdfgd"
        "dsfgsdfgsd"
        "sdfgdsfgsdfg"
        "dfgsdfgdfg"
        "sdfgsdfgsdfg"
        "sdfgdsfgsdfg"
        "sdfgsdfgsdf"
        "sdfgsdfgdsfgsdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsd fsdfgsdfgsdfgdfgsdfg"
        "sdfgdfgsdfgsdfgsdfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsddfgfg"
        "dfgsdfgsdfgsdf sdfg"
        "sdfgsdfgd"
        "dsfgsdfgsd"
        "sdfgdsfgsdfg"
        "dfgsdfgdfg"
        "sdfgsdfgsdfg"
        "sdfgdsfgsdfg"
        "sdfgsdfgsdf"
        "sdfgsdfgdsfgsdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsd fsdfgsdfgsdfgdfgsdfg"
        "sdfgdfgsdfgsdfgsdfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsddfgfg"
        "dfgsdfgsdfgsdf sdfg"
        "sdfgsdfgd"
        "dsfgsdfgsd"
        "sdfgdsfgsdfg"
        "dfgsdfgdfg"
        "sdfgsdfgsdfg"
        "sdfgdsfgsdfg"
        "sdfgsdfgsdf"
        "sdfgsdfgdsfgsdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsd fsdfgsdfgsdfgdfgsdfg"
        "sdfgdfgsdfgsdfgsdfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsddfgfg"
        "dfgsdfgsdfgsdf sdfg"
        "sdfgsdfgd"
        "dsfgsdfgsd"
        "sdfgdsfgsdfg"
        "dfgsdfgdfg"
        "sdfgsdfgsdfg"
        "sdfgdsfgsdfg"
        "sdfgsdfgsdf"
        "sdfgsdfgdsfgsdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsd fsdfgsdfgsdfgdfgsdfg"
        "sdfgdfgsdfgsdfgsdfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsddfgfg"
        "dfgsdfgsdfgsdf sdfg"
        "sdfgsdfgd"
        "dsfgsdfgsd"
        "sdfgdsfgsdfg"
        "dfgsdfgdfg"
        "sdfgsdfgsdfg"
        "sdfgdsfgsdfg"
        "sdfgsdfgsdf"
        "sdfgsdfgdsfgsdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsdfg"
        "dfgdsfgsd fsdfgsdfgsdfgdfgsdfg"
        "sdfgdfgsdfgsdfgsdfgsdfgsdf"
        "sdfgsdfgsdfgsdfgsddfgfg";
  }
}
