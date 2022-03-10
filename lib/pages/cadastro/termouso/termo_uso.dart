import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/helpers/config_screen.dart';

import '../../../componentes/button_flag.dart';
import '../../base/page_store.dart';

class TermoUso extends StatefulWidget {
  const TermoUso({Key? key}) : super(key: key);

  @override
  State<TermoUso> createState() => _TermoUsoState();
}

class _TermoUsoState extends State<TermoUso> {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  bool termosUsoAceitos = false;
  bool isTermoUso = false;
  bool isPoliticaUso = false;
  bool isPoliticaContestacao = false;

  @override
  void initState() {
    super.initState();
      setState(() {
        isTermoUso = sharedPreferences.getBool(KEY_TERMO_USO) ?? false;
        isPoliticaUso = sharedPreferences.getBool(KEY_POLITICA_USO) ?? false;
        isPoliticaContestacao =
            sharedPreferences.getBool(KEY_POLITICA_CONTESTACAO) ?? false;
        termosUsoAceitos = isTermoUso && isPoliticaUso && isPoliticaContestacao;
      });

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
                titulo: "Termo de uso",
                subTitulo:
                    "Leia com atenção todos os termos e clique em aceitar para continuar.",
                retornoClicked: onButtonBackClick),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 130,
                ),
                // termo de uso
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 8.0, right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onLerTermoUso,
                          child: const Icon(
                            FontAwesomeIcons.eye,
                            color: BUTTON_COLOR,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width * .70,
                        color: Colors.grey.shade300,
                        child: SwitchListTile(
                            value: isTermoUso,
                            title: Text("Termo de Uso"),
                            subtitle: Text("Saiba msis"),
                            activeColor: BUTTON_COLOR,
                            onChanged: (value) {
                              setState(() {
                                isTermoUso = true;
                              });
                              onTermoUsoSelecionado(0);
                            }),
                      ),
                    ],
                  ),
                ),
                // politica de uso
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 8.0, right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onLerPoliticaUso,
                          child: const Icon(
                            FontAwesomeIcons.eye,
                            color: BUTTON_COLOR,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width * .70,
                        color: Colors.grey.shade300,
                        child: SwitchListTile(
                            value: isPoliticaUso,
                            title: Text("Politica de Uso"),
                            subtitle: Text("Saiba msis"),
                            activeColor: BUTTON_COLOR,
                            onChanged: (value) {
                              setState(() {
                                isPoliticaUso = true;
                              });
                              onTermoUsoSelecionado(1);
                            }),
                      ),
                    ],
                  ),
                ),
                // politica de contestacao
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 8.0, right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onLerPoliticaContestacao,
                          child: const Icon(
                            FontAwesomeIcons.eye,
                            color: BUTTON_COLOR,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width * .70,
                        color: Colors.grey.shade300,
                        child: SwitchListTile(
                            value: isPoliticaContestacao,
                            title: Text("Politica de Contestação"),
                            subtitle: Text("Saiba mais"),
                            activeColor: BUTTON_COLOR,
                            onChanged: (value) {
                              setState(() {
                                isPoliticaContestacao = true;
                              });
                              onTermoUsoSelecionado(2);
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * .90,
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: termosUsoAceitos ? null : () {
                      isTermoUso = true;
                      onTermoUsoSelecionado(0);
                      isPoliticaUso = true;
                      onTermoUsoSelecionado(1);
                      isPoliticaContestacao = true;
                      onTermoUsoSelecionado(2);
                      onButtonBackClick();
                    },
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
          ],
        ),
      ),
    );
  }

  void onButtonBackClick() {
    GetIt.I<PageStore>().setPage(INDICE_TELA_PRE_LOGIN);
  }

  void onTermoUsoSelecionado(int indice) {
    if (indice == 0)
      sharedPreferences.setBool(KEY_TERMO_USO, isTermoUso);
    else if (indice == 1)
      sharedPreferences.setBool(KEY_POLITICA_USO, isPoliticaUso);
    else if (indice == 2)
      sharedPreferences.setBool(
          KEY_POLITICA_CONTESTACAO, isPoliticaContestacao);
  }

  void onLerTermoUso() {
    GetIt.I<PageStore>().setPage(INDICE_TELA_LER_TERMO);
  }
  void onLerPoliticaUso() {
    GetIt.I<PageStore>().setPage(INDICE_TELA_LER_POLITICA_USO);
  }
  void onLerPoliticaContestacao() {
    GetIt.I<PageStore>().setPage(INDICE_TELA_LER_POLITICA_CONTESTACAO);
  }
}
