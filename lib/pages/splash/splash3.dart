import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import 'package:taksim/helpers/config_screen.dart';

import '../base/page_store.dart';

class Splash3Widget extends StatefulWidget {
  @override
  State<Splash3Widget> createState() => _Splash3WidgetState();
}

bool jaEscolheuIdioma()
{
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  if (sharedPreferences.containsKey(KEY_PREFERENCE_IDIOMA))
  {
     return true;
  }
  else
  {
    sharedPreferences.setInt(KEY_PREFERENCE_IDIOMA, IDIOMA_PORTUGUES);
    return false;
  }
}

void moveTelaCorreta(bool value)
{
  if (value) {
    bool entrarAutomatico = false;
    if (GetIt.I<SharedPreferences>().containsKey(KEY_PASSAGEIRO)) {
      EntPassageiro passageiro = EntPassageiro();
      String? json = GetIt.I<SharedPreferences>().getString(KEY_PASSAGEIRO);
      passageiro.fromJson(json??"");
      entrarAutomatico = passageiro.manterConectado;
      if (passageiro.eMailValidado)
        GetIt.I<PageStore>().setPage(INDICE_TELA_BEM_VINDO_MAPA);
    }
    GetIt.I<PageStore>().setPage(INDICE_TELA_ON_BOARD);
  }
  else
  {
    GetIt.I<PageStore>().setPage(INDICE_TELA_ESCOLHA_IDIOMA);
  }
}

class _Splash3WidgetState extends State<Splash3Widget> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        moveTelaCorreta(jaEscolheuIdioma());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Splash3Widget - FRAME
    return Container(
      decoration:  const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash3.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/taksim_logo.png',
          width: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
