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
import 'package:taksim/pages/cadastro/passageiro/passageiro_valida_conta_store.dart';

import '../../../componentes/button_flag.dart';
import '../../../componentes/custom_text_field.dart';
import '../../base/page_store.dart';

class PassageiroValidaConta extends StatefulWidget {
  const PassageiroValidaConta({Key? key}) : super(key: key);

  @override
  State<PassageiroValidaConta> createState() => _PassageiroValidaConta();
}

class _PassageiroValidaConta extends State<PassageiroValidaConta> {
  PassageiroValidaContaStore validaContaStore = PassageiroValidaContaStore();

  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  TextEditingController digito1Controller = TextEditingController();
  TextEditingController digito2Controller = TextEditingController();
  TextEditingController digito3Controller = TextEditingController();
  TextEditingController digito4Controller = TextEditingController();

  bool mostrarAceite = true;

 // late FocusNode focusNodeDigito1;
  FocusNode focusNodeDigito2 = FocusNode();
  FocusNode focusNodeDigito3 = FocusNode();
  FocusNode focusNodeDigito4 = FocusNode();

  @override
  void initState() {
    super.initState();
    validaContaStore.passageiroLoadLocal();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    //focusNodeDigito1.dispose();
    focusNodeDigito2.dispose();
    focusNodeDigito3.dispose();
    focusNodeDigito4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: <Widget>[
                CabecalhoCadastro(
                    indiceProgressao: 4,
                    mostraProgressao: true,
                    titulo: "Código de verificação?",
                    subTitulo: "Informe o código recebido no seu E-mail " + validaContaStore.emailTemp,
                    retornoClicked: onButtonBackClick),
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 40,
                        child: TextField(
                          autofocus: true,
                          textAlign: TextAlign.center,
                          onChanged: (value)
                          {
                            validaContaStore.setDigito1(value);
                            if (validaContaStore.digito1.length == 1)
                                FocusScope.of(context).requestFocus(focusNodeDigito2);
                          },
                          maxLength: 1,
                          controller: digito1Controller,
                          enabled: !validaContaStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 40,
                        child: TextField(
                          focusNode: focusNodeDigito2,
                          textAlign: TextAlign.center,
                          onChanged: (value)
                          {
                            validaContaStore.setDigito2(value);
                            if (validaContaStore.digito2.length == 1)
                                FocusScope.of(context).requestFocus(focusNodeDigito3);
                          },
                          maxLength: 1,
                          controller: digito2Controller,
                          enabled: !validaContaStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 40,
                        child: TextField(
                          focusNode: focusNodeDigito3,
                          textAlign: TextAlign.center,
                          onChanged: (value)
                          {
                            validaContaStore.setDigito3(value);
                            if (validaContaStore.digito3.length == 1)
                                FocusScope.of(context).requestFocus(focusNodeDigito4);
                          },
                          maxLength: 1,
                          controller: digito3Controller,
                          enabled: !validaContaStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 40,
                        child: TextField(
                          focusNode: focusNodeDigito4,
                          textAlign: TextAlign.center,
                          onChanged: validaContaStore.setDigito4,
                          maxLength: 1,
                          controller: digito4Controller,
                          enabled: !validaContaStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                  ],
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
                        onPressed: validaContaStore.isFormOK
                            ? onButtonProximoClick
                            : null,
                        child: validaContaStore.loading
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
            ),
          );
        }),
      ),
    );
  }

  void onButtonProximoClick() {
    sharedPreferences.setString(
        KEY_STATUS_PASSAGEIRO, STATUS_PASSAGEIRO_VALIDA_CONTA);

    validaContaStore.verificaEmail().then((value) {
      if (value) {
        GetIt.I<PageStore>().setPage(INDICE_TELA_CADASTRO_DOCUMENTO);
      } else
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Validação E-mail"),
            content: Text(
                "Não conseguimos validar seu E-mail, seu código não confere tente novamente."),
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
    GetIt.I<PageStore>().setPage(INDICE_TELA_PASSAGEIRO_CADASTRO_2);
  }
}
