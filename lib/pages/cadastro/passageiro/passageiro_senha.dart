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

import '../../../componentes/button_flag.dart';
import '../../../componentes/custom_text_field.dart';
import '../../base/page_store.dart';

class PassageiroCadastroSenha extends StatefulWidget {
  const PassageiroCadastroSenha({Key? key}) : super(key: key);

  @override
  State<PassageiroCadastroSenha> createState() => _PassageiroCadastroSenha();
}

class _PassageiroCadastroSenha extends State<PassageiroCadastroSenha> {
  PassageiroSenhaStore passageiroSenhaStore = PassageiroSenhaStore();

  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  TextEditingController senhaController = TextEditingController();
  TextEditingController senhaConfirmacaoController = TextEditingController();

  bool mostrarSenha = true;
  bool mostrarSenhaConfirma = true;
  IconData iconeSenha = FontAwesomeIcons.eye;
  IconData iconeSenhaConfirmada = FontAwesomeIcons.eye;

  @override
  void initState() {
    super.initState();
    passageiroSenhaStore.passageiroLoadLocal();
    senhaController.text = passageiroSenhaStore.senha;
    //senhaConfirmacaoController.text = passageiroSenhaStore.manterConectado;
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
                  mostraProgressao: true,
                  titulo: "Criar senha",
                  subTitulo:
                      "Legal, para criarmos uma nova senha com mais segurança, precisamos que siga as regras nas informações.",
                  retornoClicked: onButtonBackClick,
              mostrarBotaoRetorno: true,),
              SizedBox(
                height: 140,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: CustomTextField(
                  label: 'Senha',
                  hint: 'Digite a senha ...',
                  enabled: !passageiroSenhaStore.loading,
                  controller: senhaController,
                  onChanged: passageiroSenhaStore.setSenha,
                  textInputType: TextInputType.name,
                  obscure: mostrarSenha,
                  suffix: CustomIconButton(
                    onTap: () {
                      setState(() {
                        mostrarSenha = !mostrarSenha;
                        if (mostrarSenha)
                          iconeSenha = FontAwesomeIcons.eye;
                        else
                          iconeSenha = FontAwesomeIcons.eyeSlash;
                      });
                    },
                    iconData: iconeSenha,
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
                  label: 'Confirma senha',
                  hint: 'Confirma senha ....',
                  enabled: !passageiroSenhaStore.loading,
                  controller: senhaConfirmacaoController,
                  onChanged: passageiroSenhaStore.setConfirmaSocial,
                  textInputType: TextInputType.name,
                  obscure: mostrarSenhaConfirma,
                  suffix: CustomIconButton(
                    onTap: () {
                      setState(() {
                        mostrarSenhaConfirma = !mostrarSenhaConfirma;
                        if (mostrarSenhaConfirma)
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
                height: 15,
              ),
              // toggle
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[200],
                ),
                child: SwitchListTile(
                    value: passageiroSenhaStore.manterConectado,
                    title: Text("Lembrar me"),
                    subtitle: Text("Manter conectado"),
                    activeColor: BUTTON_COLOR,
                    onChanged: (value) {
                      setState(() {
                        passageiroSenhaStore.setManterConectado(value);
                      });
                    }),
              ),
              SizedBox(
                height: 5,
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
                      onPressed: passageiroSenhaStore.isFormOK
                          ? onButtonProximoClick
                          : null,
                      child: passageiroSenhaStore.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text(
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
    passageiroSenhaStore.passageiroSaveLocal();
    sharedPreferences.setString(KEY_STATUS_PASSAGEIRO, STATUS_PASSAGEIRO_SENHA);
    passageiroSenhaStore.enviaSenha().then((value) {
      if (value) {
        GetIt.I<PageStore>().setPage(INDICE_TELA_CAPTURA_IMAGEM);
      } else
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Registro de Senha"),
            content: Text(
                "Problemas com o envio da sua senha tente novamente."),
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
    GetIt.I<PageStore>().setPage(INDICE_TELA_CADASTRO_DOCUMENTO);
  }
}
