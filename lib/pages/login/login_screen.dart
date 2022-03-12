import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/componentes/custom_icon_button.dart';
import 'package:taksim/helpers/config_screen.dart';
import 'package:taksim/pages/cadastro/passageiro/passageiro_parte_1_store.dart';
import 'package:taksim/pages/cadastro/passageiro/passageiro_senha_store.dart';

import '../../../componentes/custom_text_field.dart';
import '../base/page_store.dart';
import 'login_screen_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  LoginScreenStore loginScreenStore = LoginScreenStore();
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  bool mostrarSenha = true;
  IconData iconeSenha = FontAwesomeIcons.eye;
  IconData iconeSenhaConfirmada = FontAwesomeIcons.eye;

  @override
  void initState() {
    super.initState();
    loginScreenStore.passageiroLoadLocal();
    if (loginScreenStore.manterConectado) {
      emailController.text = loginScreenStore.email;
      senhaController.text = loginScreenStore.senha;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(builder: (_) {
          return Column(
            children: <Widget>[
              CabecalhoCadastro(
                  indiceProgressao: 6,
                  mostraProgressao: false,
                  titulo: "Login",
                  subTitulo:
                      "Acesse sua conta com os dados já cadastrados",
                  retornoClicked: onButtonBackClick),
              SizedBox(
                height: 320,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: CustomTextField(
                  label: 'E-mail',
                  hint: 'Digite seu e-mail ...',
                  enabled: !loginScreenStore.loading,
                  controller: emailController,
                  onChanged: loginScreenStore.setEmail,
                  textInputType: TextInputType.emailAddress,
                  prefix: CustomIconButton(
                    onTap: () {},
                    iconData: FontAwesomeIcons.mailBulk,
                    radius: 50,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: CustomTextField(
                  label: 'Senha',
                  hint: 'Digite senha ....',
                  enabled: !loginScreenStore.loading,
                  controller: senhaController,
                  onChanged: loginScreenStore.setSenha,
                  textInputType: TextInputType.text,
                  obscure: mostrarSenha,
                  suffix: CustomIconButton(
                    onTap: () {
                      setState(() {
                        mostrarSenha = !mostrarSenha;
                        if (mostrarSenha)
                          iconeSenhaConfirmada = FontAwesomeIcons.eye;
                        else
                          iconeSenhaConfirmada = FontAwesomeIcons.eyeSlash;
                      });
                    },
                    iconData: iconeSenhaConfirmada,
                    radius: 50,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // toggle
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                      onTap: () {},
                      child: Text("Esqueci minha senha", style: TextStyle(color: BUTTON_COLOR),),
                    ),
                ),
              ),
              SizedBox(
                height: 15,
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
                      onPressed: loginScreenStore.isFormOK
                          ? onButtonProximoClick
                          : null,
                      child: loginScreenStore.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text(
                              "ENTRAR",
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
              SizedBox(
                height: 5,
              ),
            ],
          );
        }),
      ),
    );
  }

  void onButtonProximoClick() {
    sharedPreferences.setString(KEY_STATUS_PASSAGEIRO, STATUS_PASSAGEIRO_LOGIN);
    loginScreenStore.validaLogin().then((value) {
      if (value) {
        GetIt.I<PageStore>().setPage(INDICE_TELA_CAPTURA_IMAGEM);
      } else
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Login Problema"),
            content: Text(
                "Problemas com o seu login ou senha tente novamente."),
            actions: [
              ElevatedButton(
                  onPressed: () { Navigator.pop(context); },
                  child: Text("Ok")),
            ],
          ),
          barrierDismissible: false,
        );
    });
  }

  void onButtonBackClick() {
    //GetIt.I<PageStore>().setPage(INDICE_TELA_CADASTRO_DOCUMENTO);
  }
}
