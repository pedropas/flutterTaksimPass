import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/componentes/custom_button.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import 'package:taksim/helpers/config_screen.dart';
import '../../componentes/divider_widget.dart';
import '../base/page_store.dart';

class PreLogin extends StatefulWidget {
  @override
  State<PreLogin> createState() => _PreLoginState();
}

class _PreLoginState extends State<PreLogin> {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  bool isTermoUsoGeral = false;
  int quemChamou = 0;

  @override
  void initState() {
    super.initState();
      setState(() {
        isTermoUsoGeral = (sharedPreferences.getBool(KEY_TERMO_USO) ?? false)
                  && (sharedPreferences.getBool(KEY_POLITICA_USO) ?? false)
                  && (sharedPreferences.getBool(KEY_POLITICA_CONTESTACAO) ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Splash3Widget - FRAME
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/SplashPass.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/taksim_logo.png',
                  width: 150,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 150,
                ),
                // bem vindo
                Text(
                  "Seja bem-vindo !",
                  style: TextStyle(
                    fontFamily: "Montserrat Bold",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                // Ja tenho cadastro
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: ElevatedButton(
                    onPressed: jaTenhoCadastro,
                    child: Text(
                      "JÁ TENHO CONTA",
                      style: TextStyle(
                        fontFamily: "Montserrat Bold",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BUTTON_COLOR),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // cadastre-me
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2.0, color: BUTTON_COLOR),
                    ),
                    onPressed: cadastreMe,
                    child: Text(
                      "CADASTRAR-ME",
                      style: TextStyle(
                        fontFamily: "Montserrat Bold",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: DividerWidget(
                          corLinha: Colors.white54,
                        ),
                      ),
                      Text(
                        " ou ",
                        style: TextStyle(
                            fontFamily: "Montserrat Bold",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white54),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: DividerWidget(
                          corLinha: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // botoes login google apple facebook
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomButton(imageName: 'assets/images/googleDark.png',
                                           comSombra: false,
                                           backGroundColor: Colors.transparent,
                             buttonFunction: googleLogin),
                      CustomButton(imageName: 'assets/images/facebook.png',
                          comSombra: false,
                          backGroundColor: Colors.black,
                          buttonFunction: facebookLogin),
                      CustomButton(imageName: 'assets/images/apple.png',
                          comSombra: false,
                          backGroundColor: Colors.black,
                          buttonFunction: appleLogin),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: visualizarTermoUso,
                  child: Text(
                    "Ao avançar, declaro que li e concordo com os",// Termos de uso e a Politica de Privacidade. ",
                    style: TextStyle(
                      fontFamily: "Montserrat Bold",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: visualizarTermoUso,
                  child: Text(
                    "Termos de uso e a Politica de Privacidade.",
                    style: TextStyle(
                      fontFamily: "Montserrat Bold",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
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

  void visualizarTermoUso()
  {
    GetIt.I<PageStore>().setPage(INDICE_TELA_TERMO_USO);
  }

  void mostraMensagem()
  {
    showDialog(context: context, builder: (_) =>
      AlertDialog(
        title: Text("Termos e Aceites"),
        content: Text("Você não aceitou os termos e as politicas de uso deste aplicativo se continuar estará aceitando."),
        actions: [
          ElevatedButton(onPressed: aceitarContinuar, child: Text("ACEITAR E CONTINUAR")),
          ElevatedButton(onPressed: ()
          {
            Navigator.pop(context);
            visualizarTermoUso();
          }
          , child: Text("VER TERMOS")),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("NÀO ACEITAR")),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void aceitarContinuar()
  {
    Navigator.pop(context);
    sharedPreferences.setBool(KEY_TERMO_USO, true);
    sharedPreferences.setBool(KEY_POLITICA_USO, true);
    sharedPreferences.setBool(KEY_POLITICA_CONTESTACAO, true);
    isTermoUsoGeral = true;
    switch (quemChamou)
    {
      case 1:
        jaTenhoCadastro();
        break;
      case 2:
        cadastreMe();
        break;
      case 3:
        googleLogin();
        break;
      case 4:
        appleLogin();
        break;
      case 5:
        facebookLogin();
        break;
    }
  }

  void jaTenhoCadastro()
  {
    quemChamou = 1;
    print("Ja tenho");
    if(!isTermoUsoGeral)
      {
        mostraMensagem();
        return;
      }
    else{
      GetIt.I<PageStore>().setPage(INDICE_TELA_LOGIN);
    }
  }

  void cadastreMe() {
    quemChamou = 2;

    if (!isTermoUsoGeral) {
      mostraMensagem();
      return;
    }
    else if (isPreCadastro()){
      GetIt.I<PageStore>().setPage(INDICE_TELA_PASSAGEIRO_CADASTRO_1);
    }
  }
  void continuarCadastro()
  {

    Navigator.pop(context);
    switch (sharedPreferences.getString(KEY_STATUS_PASSAGEIRO))
    {
      case STATUS_PASSAGEIRO_ONBOARD_1:
        GetIt.I<PageStore>().setPage(INDICE_TELA_PASSAGEIRO_CADASTRO_1);
        return;
      case STATUS_PASSAGEIRO_ONBOARD_2:
        GetIt.I<PageStore>().setPage(INDICE_TELA_PASSAGEIRO_CADASTRO_2);
        return;
      case STATUS_PASSAGEIRO_VALIDA_CONTA:
      case STATUS_PASSAGEIRO_DOCUMENTO:
        GetIt.I<PageStore>().setPage(INDICE_TELA_CADASTRO_DOCUMENTO);
        return;
      case STATUS_PASSAGEIRO_SENHA:
        GetIt.I<PageStore>().setPage(INDICE_TELA_CADASTRO_SENHA);
        return;
      case STATUS_PASSAGEIRO_CAPTURA_FOTO:
        GetIt.I<PageStore>().setPage(INDICE_TELA_CAPTURA_IMAGEM);
        return;
    }
    GetIt.I<PageStore>().setPage(INDICE_TELA_PASSAGEIRO_CADASTRO_1);
  }

  void reiniciarCadastro()
  {
    Navigator.pop(context);
    GetIt.I<PageStore>().setPage(INDICE_TELA_PASSAGEIRO_CADASTRO_1);
  }

  bool isPreCadastro()
  {
    if (sharedPreferences.containsKey(KEY_STATUS_PASSAGEIRO)) {
      showDialog(context: context, builder: (_) =>
          AlertDialog(
            title: Text("Cadastro Efetuado"),
            content: Text(
                "Você ja iniciou seu cadastro deseja continuar de onde parou ou reinicia-lo ?"),
            actions: [
              ElevatedButton(
                  onPressed: continuarCadastro, child: Text("CONTINUAR")),
              ElevatedButton(
                  onPressed: reiniciarCadastro, child: Text("REINICIAR")),
              ElevatedButton(onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              }, child: Text("CANCELAR")),
            ],
          ),
        barrierDismissible: false,
      );
      return false;
    }
    return true;
  }

  void googleLogin()
  {
    quemChamou = 3;
    print("Tipo google");
    if(!isTermoUsoGeral)
    {
      mostraMensagem();
      return;
    }
  }

  void appleLogin()
  {
    quemChamou = 4;
    print("Tipo Apple");
    if(!isTermoUsoGeral)
    {
      mostraMensagem();
      return;
    }
  }

  void facebookLogin()
  {
    quemChamou = 5;
    print("Tipo facebook");
    if(!isTermoUsoGeral)
    {
      mostraMensagem();
      return;
    }
  }
}
