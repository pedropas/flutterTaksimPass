import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/componentes/custom_icon_button.dart';
import 'package:taksim/helpers/config_screen.dart';
import 'package:taksim/pages/cadastro/passageiro/passageiro_parte_2_store.dart';

import '../../../componentes/button_flag.dart';
import '../../../componentes/custom_text_field.dart';
import '../../base/page_store.dart';

class PassageiroCadastroParte2 extends StatefulWidget {
  const PassageiroCadastroParte2({Key? key}) : super(key: key);

  @override
  State<PassageiroCadastroParte2> createState() => _PassageiroCadastroParte2();
}

class _PassageiroCadastroParte2 extends State<PassageiroCadastroParte2> {
  PassageiroParte2Store passageiroParte2Store = PassageiroParte2Store();

  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  TextEditingController emailController = TextEditingController();
  TextEditingController celularController = TextEditingController();

  bool mostrarAceite = true;

  var maskFormatter = MaskTextInputFormatter(
    mask: '+## (##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    initialText: 'Digite seu telefone',
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    passageiroParte2Store.passageiroLoadLocal();
    emailController.text = passageiroParte2Store.email;
    celularController.text = passageiroParte2Store.celular;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(builder: (_) {
          return Column(
            children: <Widget>[
              CabecalhoCadastro(
                  indiceProgressao: 3,
                  mostraProgressao: true,
                  titulo: "Quem é você?",
                  subTitulo: "Preencha abaixo com seus dados",
                  retornoClicked: onButtonBackClick,
              mostrarBotaoRetorno: true,),
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomTextField(
                  label: 'E-mail',
                  hint: 'Seu e-mail aqui ...',
                  enabled: !passageiroParte2Store.loading,
                  controller: emailController,
                  onChanged: passageiroParte2Store.setEmail,
                  textInputType: TextInputType.emailAddress,
                  prefix: CustomIconButton(
                    onTap: () {},
                    iconData: FontAwesomeIcons.mailBulk,
                    radius: 50,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomTextField(
                  label: 'Celular',
                  hint: 'Seu celular aqui ....',
                  enabled: !passageiroParte2Store.loading,
                  controller: celularController,
                  onChanged: passageiroParte2Store.setCelular,
                  textInputType: TextInputType.phone,
                  maskTextInputFormatter: maskFormatter,
                  prefix: CustomIconButton(
                    onTap: () {},
                    iconData: FontAwesomeIcons.phone,
                    radius: 50,
                  ),
                ),
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
                      onPressed: passageiroParte2Store.isFormOK
                          ? onButtonProximoClick
                          : null,
                      child: passageiroParte2Store.loading
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
    sharedPreferences.setString(
        KEY_STATUS_PASSAGEIRO, STATUS_PASSAGEIRO_ONBOARD_2);
    passageiroParte2Store.verificaEmailLocal().then((value) {
      if (value) {
        GetIt.I<PageStore>().setPage(INDICE_TELA_VALIDA_CONTA);
        passageiroParte2Store.passageiroSaveLocal();
      } else
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("E-mail cadastrado"),
            content: Text(
                "Já encontramos esse e-mail no cadastro, o que você deseja fazer?"),
            actions: [
              ElevatedButton(
                  onPressed: setTelaLogin,
                  child: Text("Logar digitanto a senha")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cadastrar outro e-mail")),
              ElevatedButton(
                  onPressed: setTelaRecuperarSenha,
                  child: Text("Recuperar a sua senha")),
              ElevatedButton(
                  onPressed: () { Navigator.pop(context); },
                  child: Text("Cancelar")),
            ],
          ),
          barrierDismissible: false,
        );
    });
  }

  setTelaLogin() {
    GetIt.I<PageStore>().setPage(INDICE_TELA_LOGIN);
  }

  setTelaRecuperarSenha() {
    GetIt.I<PageStore>().setPage(INDICE_TELA_RECUPERA_SENHA);
  }

  void onButtonBackClick() {
    GetIt.I<PageStore>().setPage(INDICE_TELA_PASSAGEIRO_CADASTRO_1);
  }
}
