import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/helpers/config_screen.dart';

import '../../../componentes/button_flag.dart';
import '../../base/page_store.dart';

class EscolhaIdioma extends StatefulWidget {
  const EscolhaIdioma({Key? key}) : super(key: key);

  @override
  State<EscolhaIdioma> createState() => _EscolhaIdiomaState();
}

class _EscolhaIdiomaState extends State<EscolhaIdioma> {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  int getIdioma() {
    return sharedPreferences.getInt(KEY_PREFERENCE_IDIOMA) ?? IDIOMA_PORTUGUES;
  }

  int idiomaSelecionado = 0;

  @override
  void initState() {
    super.initState();
    idiomaSelecionado = getIdioma();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            CabecalhoCadastro(
                indiceProgressao: 1,
                mostraProgressao: true,
                titulo: "Idioma",
                subTitulo: "Escolha o de sua preferência",
                retornoClicked: onButtonBackClick,
            mostrarBotaoRetorno: true,),
            SizedBox(
              height: 160,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonFlag(
                  flagImage: 'assets/images/Brasil-Flag.png',
                  flagName: 'Português',
                  isSelected: idiomaSelecionado == IDIOMA_PORTUGUES,
                  onIdiomaSelecionado: onPortuguesClicked,
                ),
                ButtonFlag(
                  flagImage: 'assets/images/USA-Flag.png',
                  flagName: 'Inglesh',
                  isSelected: idiomaSelecionado == IDIOMA_INGLES,
                  onIdiomaSelecionado: onInglesClicked,
                ),
                ButtonFlag(
                  flagImage: 'assets/images/Espanha-Flag.png',
                  flagName: 'Espanhol',
                  isSelected: idiomaSelecionado == IDIOMA_ESPANHOL,
                  onIdiomaSelecionado: onEspanholClicked,
                ),
              ],
            ),
            SizedBox(
              height: 130,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * .90,
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onButtonBackClick,
                    child: Text(
                      "PRÓXIMO",
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
    GetIt.I<PageStore>().setPage(INDICE_TELA_ON_BOARD);
  }

  void onPortuguesClicked() {
    setState(() {
      idiomaSelecionado = IDIOMA_PORTUGUES;
    });
    onIdiomaSelecionado(idiomaSelecionado);
  }

  void onInglesClicked() {
    setState(() {
      idiomaSelecionado = IDIOMA_INGLES;
    });
    onIdiomaSelecionado(idiomaSelecionado);
  }

  void onEspanholClicked() {
    setState(() {
      idiomaSelecionado = IDIOMA_ESPANHOL;
    });
    onIdiomaSelecionado(idiomaSelecionado);
  }

  void onIdiomaSelecionado(int idioma) {
    sharedPreferences.setInt(KEY_PREFERENCE_IDIOMA, idioma);
  }
}
