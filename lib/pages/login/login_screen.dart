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
import 'package:taksim/pages/login/logn_bloc.dart';

import '../../../componentes/custom_text_field.dart';
import '../../componentes/custom_text_field_bloc.dart';
import '../base/page_store.dart';
import 'login_screen_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  bool mostrarSenha = true;
  IconData iconeSenha = FontAwesomeIcons.eye;
  IconData iconeSenhaConfirmada = FontAwesomeIcons.eye;
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          GetIt.I<PageStore>().setPage(INDICE_TELA_BEM_VINDO_MAPA);
          break;
        case LoginState.FAIL:
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Login Problema"),
              content:
                  Text("Problemas com o seu login ou senha tente novamente."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _loginBloc.changeStatus(LoginState.IDLE);
                    },
                    child: Text("Ok")),
              ],
            ),
            barrierDismissible: false,
          );
          break;
        case LoginState.CELPHONE_DIFERENTE:
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Login Problema"),
              content: Text(
                  "Identificamos que existe outra conta já registrada neste aparelho. Deseja substitui-la ?"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _loginBloc.changeStatus(LoginState.TROCA_CONFIRMADA);
                    _loginBloc.trocaConta();
                  },
                  child: Text("Substituir conta"),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _loginBloc.changeStatus(LoginState.TROCA_RECUSADA);
                    },
                    child: Text("Manter a conta")),
              ],
            ),
            barrierDismissible: false,
          );
          break;
        case LoginState.IDLE:
        case LoginState.LOADING:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.IDLE,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CabecalhoCadastro(
                      indiceProgressao: 6,
                      mostraProgressao: false,
                      titulo: "Login",
                      subTitulo: "Acesse sua conta com os dados já cadastrados",
                      retornoClicked: (){},
                  mostrarBotaoRetorno: false,),
                  const SizedBox(
                    height: 280,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: CustomTextFieldBloc(
                      label: 'E-mail',
                      hint: 'Digite seu e-mail ...',
                      stream: _loginBloc.outEmail,
                      enabled: snapshot.data == LoginState.IDLE,
                      onChanged: _loginBloc.changeEmail,
                      textInputType: TextInputType.emailAddress,
                      prefix: CustomIconButton(
                        onTap: () {},
                        iconData: FontAwesomeIcons.mailBulk,
                        radius: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: CustomTextFieldBloc(
                      label: 'Senha',
                      hint: 'Digite senha ....',
                      enabled: snapshot.data == LoginState.IDLE,
                      stream: _loginBloc.outPassword,
                      onChanged: _loginBloc.changePassword,
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
                  const SizedBox(
                    height: 5,
                  ),
                  // toggle
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Esqueci minha senha",
                          style: TextStyle(color: BUTTON_COLOR),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                        child: StreamBuilder<bool>(
                            stream: _loginBloc.outSubmitValid,
                            builder: (context, snapshot) {
                              return ElevatedButton(
                                onPressed: snapshot.hasData
                                    ? _loginBloc.onEntrarClicked
                                    : null,
                                child: snapshot.data == LoginState.LOADING
                                    ? const CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      )
                                    : const Text(
                                        "ENTRAR",
                                        style: TextStyle(
                                          fontFamily: "Montserrat Bold",
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                              );
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }
}
