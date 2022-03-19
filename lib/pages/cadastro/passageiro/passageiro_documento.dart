import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/componentes/custom_combobox.dart';
import 'package:taksim/componentes/custom_icon_button.dart';
import 'package:taksim/helpers/config_screen.dart';
import 'package:taksim/pages/cadastro/passageiro/passageiro_documento_store.dart';

import '../../../componentes/custom_text_field.dart';
import '../../base/page_store.dart';

class PassageiroCadastroDocumento extends StatefulWidget {
  const PassageiroCadastroDocumento({Key? key}) : super(key: key);

  @override
  State<PassageiroCadastroDocumento> createState() =>
      _PassageiroCadastroDocumento();
}

class _PassageiroCadastroDocumento extends State<PassageiroCadastroDocumento> {
  PassageiroDocumentoStore passageiroDocumentoStore =
      PassageiroDocumentoStore();

  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  TextEditingController documentorController = TextEditingController();

  bool mostrarAceite = true;

  var maskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    initialText: 'Digite seu CPF',
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    passageiroDocumentoStore.passageiroLoadLocal();
    documentorController.text = passageiroDocumentoStore.documento;
    if (!passageiroDocumentoStore.listOfTipoDocumento.contains(passageiroDocumentoStore.tipoDocumento))
    {
      passageiroDocumentoStore.tipoDocumento = passageiroDocumentoStore.listOfTipoDocumento[0];
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
                  indiceProgressao: 5,
                  mostraProgressao: true,
                  titulo: "Dados pessoais",
                  subTitulo: "Insira seus dados do contrato",
                  retornoClicked: onButtonBackClick,
              mostrarBotaoRetorno: true,),
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child:
                CustomComboBox(
                  hintText: 'Selecione tipo documento',
                  label: 'Tipo Documento',
                  listColor: Colors.white,
                  listItens: passageiroDocumentoStore.listOfTipoDocumento,
                  valorEscolhido: passageiroDocumentoStore.tipoDocumento,
                  selectedValue: onChangeCombo,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomTextField(
                  label: 'Documento',
                  hint: 'Seu documento aqui ....',
                  enabled: !passageiroDocumentoStore.loading,
                  controller: documentorController,
                  onChanged: passageiroDocumentoStore.setDocumento,
                  textInputType: TextInputType.text,
                  prefix: CustomIconButton(
                    onTap: () {},
                    iconData: FontAwesomeIcons.idCard,
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
                      onPressed: passageiroDocumentoStore.isFormOK
                          ? onButtonProximoClick
                          : null,
                      child: passageiroDocumentoStore.loading
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
    passageiroDocumentoStore.passageiroSaveLocal();
    sharedPreferences.setString(
        KEY_STATUS_PASSAGEIRO, STATUS_PASSAGEIRO_DOCUMENTO);

    passageiroDocumentoStore.enviaDocumento().then((value) {
      if (value) {
        GetIt.I<PageStore>().setPage(INDICE_TELA_CADASTRO_SENHA);
      } else
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Registro de documento"),
            content: Text(
                "Problemas com o envio do seu documento tente novamente."),
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

  void onChangeCombo(Object? value)
  {
    setState(() {
      passageiroDocumentoStore.tipoDocumento = value as String;
    });
  }

  void onButtonBackClick() {
    GetIt.I<PageStore>().setPage(INDICE_TELA_PASSAGEIRO_CADASTRO_2);
  }
}
