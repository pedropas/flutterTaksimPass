import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/helpers/config_screen.dart';

import '../../../componentes/button_flag.dart';
import '../../base/page_store.dart';

class TextoPoliticaContestacao extends StatefulWidget {
  const TextoPoliticaContestacao({Key? key}) : super(key: key);

  @override
  State<TextoPoliticaContestacao> createState() => _TextoPoliticaContestacaoState();
}

class _TextoPoliticaContestacaoState extends State<TextoPoliticaContestacao> {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  bool mostrarAceite = true;


  Future<String> getTextoTermoContestacao() async {
    return "teste";
  }

  @override
  void initState() {
    super.initState();
      if (sharedPreferences.getBool(KEY_POLITICA_CONTESTACAO) != null)
      {
        mostrarAceite = sharedPreferences.getBool(KEY_POLITICA_CONTESTACAO) ?? true;
        setState(() {
          mostrarAceite = !mostrarAceite;
        });
      }
    getTextoTermoContestacao().then((value) {});
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
                titulo: "Politica de Contestacao",
                subTitulo:
                    "Leia com atenção todo o termo e clique em aceitar para continuar.",
                retornoClicked: onButtonBackClick,
            mostrarBotaoRetorno: true,),
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
                      onTermoContestacaoSelecionado();
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

  void onTermoContestacaoSelecionado() {
    sharedPreferences.setBool(KEY_POLITICA_CONTESTACAO, true);
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
