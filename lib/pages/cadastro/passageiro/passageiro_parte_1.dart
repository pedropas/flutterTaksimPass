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

import '../../../componentes/button_flag.dart';
import '../../../componentes/custom_text_field.dart';
import '../../base/page_store.dart';

class PassageiroCadastroParte1 extends StatefulWidget {
  const PassageiroCadastroParte1({Key? key}) : super(key: key);

  @override
  State<PassageiroCadastroParte1> createState() => _PassageiroCadastroParte1();
}

class _PassageiroCadastroParte1 extends State<PassageiroCadastroParte1> {
  PassageiroParte1Store passageiroParte1Store = PassageiroParte1Store();

  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  TextEditingController nomeCompletoController = TextEditingController();
  TextEditingController nomeSocialController = TextEditingController();

  bool mostrarAceite = true;

  @override
  void initState() {
    super.initState();
    passageiroParte1Store.passageiroLoadLocal();
    nomeCompletoController.text = passageiroParte1Store.nomeCompleto;
    nomeSocialController.text = passageiroParte1Store.nomeSocial;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(builder:(_){
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
                  label: 'Nome completo',
                  hint: 'Seu nome aqui ...',
                  enabled: !passageiroParte1Store.loading,
                  controller: nomeCompletoController,
                  onChanged: passageiroParte1Store.setNomeCompleto,
                  textInputType: TextInputType.name,
                  prefix: CustomIconButton(
                    onTap: () {},
                    iconData: FontAwesomeIcons.userAlt,
                    radius: 50,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomTextField(
                  label: 'Nome social',
                  hint: 'Seu nome social ....',
                  enabled: !passageiroParte1Store.loading,
                  controller: nomeSocialController,
                  onChanged: passageiroParte1Store.setNomeSocial,
                  textInputType: TextInputType.name,
                  prefix: CustomIconButton(
                    onTap: () {},
                    iconData: FontAwesomeIcons.userAstronaut,
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
                      onPressed: passageiroParte1Store.isFormOK
                          ? onButtonProximoClick
                          : null,
                      child: passageiroParte1Store.loading ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ) : Text(
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
    passageiroParte1Store.passageiroSaveLocal();
    sharedPreferences.setString(
        KEY_STATUS_PASSAGEIRO, STATUS_PASSAGEIRO_ONBOARD_1);
    GetIt.I<PageStore>().setPage(INDICE_TELA_PASSAGEIRO_CADASTRO_2);
  }

  void onButtonBackClick() {
    GetIt.I<PageStore>().setPage(INDICE_TELA_PRE_LOGIN);
  }
}
