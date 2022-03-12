import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dominio/ent_passageiro.dart';

part 'imagem_capturada_store.g.dart';

class ImagemCapturadaStore = _ImagemCapturadaStore with _$ImagemCapturadaStore;

abstract class _ImagemCapturadaStore with Store {

  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  EntPassageiro passageiro = EntPassageiro();

  @observable
  String? foto;

  @action
  void setFoto(String value){
    passageiro.getLocal();
    foto = value;
    passageiro.foto = value;
    passageiro.setLocal();
  }

  @observable
  bool loading = false;


  @action
  void passageiroSaveLocal()
  {
    loading = true;
    passageiro.foto = foto ?? '';
    passageiro.setLocal();
    loading = false;
  }

  @action
  Future<bool> enviaFoto() async
  {
    bool resp = false;
    loading = true;
    resp = await passageiro.enviaFoto();
    if (resp) {
      String retorno = passageiro.getRetorno();
      resp = (retorno.contains('PASSAGEIRO_FOTO_OK'));
    }
    loading = false;
    return resp;
  }


}
// flutter packages pub run build_runner watch
