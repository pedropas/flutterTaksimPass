import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/componentes/cabecalho_cadastro.dart';
import 'package:taksim/pages/cadastro/captura/imagem_capturada_store.dart';

import '../../../helpers/config_screen.dart';
import '../../base/page_store.dart';

class CapturaImagem extends StatefulWidget {
  const CapturaImagem({Key? key}) : super(key: key);

  @override
  _CapturaImagemState createState() => _CapturaImagemState();
}

class _CapturaImagemState extends State<CapturaImagem> {
  final ImagePicker _picker = ImagePicker();

  String imagemCapturada = 'assets/images/user_icon.png';
  bool mostrarPainelFotoHoraSelfie = true;
  ImagemCapturadaStore imagemCapturadaStore = ImagemCapturadaStore();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 250,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(180),
                    child: Image.asset(
                      imagemCapturada,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // chora da selfie
          Container(
            child: mostrarPainelFotoHoraSelfie
                ? Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                      height: 400,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: CabecalhoCadastro(
                              mostraProgressao: false,
                              subTitulo:
                                  'Precisamos de uma foto sua para combater fraudes. Escolha um ambiente iluminado e com o fundo claro.',
                              titulo: 'Hora da selfie',
                              indiceProgressao: 6,
                              retornoClicked: onButtonBackClick,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: SizedBox(
                              child: Center(
                                child: Image.asset(
                                  'assets/images/selfie.png',
                                  width: 150,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                      onPressed: onVoltarCadastro,
                                      child: Text("VOLTAR")),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: onTirarFotoClick,
                                      child: Text("TIRAR FOTO")),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          ),
          // depois da selfie
          Container(
            child: !mostrarPainelFotoHoraSelfie
                ? Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                      height: 400,
                      child: Column(
                        children: [
                          CabecalhoCadastro(
                            mostraProgressao: false,
                            subTitulo: 'Sua foto registrada com sucesso.',
                            titulo: 'Pronto, selfie ok',
                            indiceProgressao: 6,
                            retornoClicked: onButtonBackClick,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: SizedBox(
                              child: Center(
                                child: Image.asset(
                                  'assets/images/selfie.png',
                                  width: 150,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                      onPressed: onNaoGosteiFoto,
                                      child: Text("NÃO GOSTEI")),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: onFotoAceita,
                                      child: Text("FINALIZAR")),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  void onFotoAceita() {
    GetIt.I<SharedPreferences>().setString(KEY_STATUS_PASSAGEIRO, STATUS_PASSAGEIRO_CAPTURA_FOTO);
    GetIt.I<PageStore>().setPage(INDICE_TELA_LOGIN);
  }

  void onVoltarCadastro() {
    GetIt.I<SharedPreferences>().setString(KEY_STATUS_PASSAGEIRO, STATUS_PASSAGEIRO_CAPTURA_FOTO);
    GetIt.I<PageStore>().setPage(INDICE_TELA_CADASTRO_SENHA);
  }

  void onNaoGosteiFoto() {
    setState(() {
      mostrarPainelFotoHoraSelfie = true;
    });
  }

  void onTirarFotoClick() {
    _picker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        setState(() {
          imagemCapturada = value.path;
          //       imagem.readAsString().then((value) => ());
          mostrarPainelFotoHoraSelfie = false;
        });
      } else {
        mostrarPainelFotoHoraSelfie = true;
        return;
      }
    });
  }

  void onButtonBackClick() {}
}
