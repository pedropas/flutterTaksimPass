import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dominio/ent_passageiro.dart';

part 'imagem_capturada_store.g.dart';

class ImagemCapturadaStore = _ImagemCapturadaStore with _$ImagemCapturadaStore;

abstract class _ImagemCapturadaStore with Store {

  @observable
  XFile? arquivoFoto;

  @action
  void setArquivoFoto(XFile value) => arquivoFoto = value;

  @observable
  bool loading = false;

  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  EntPassageiro passageiro = EntPassageiro();

  @action
  void passageiroLoadLocal()
  {
    passageiro.getLocal();
   // arquivoFoto.
  }

  @action
  void passageiroSaveLocal()
  {
    loading = true;
    passageiro.foto = (arquivoFoto?.readAsString() as String);
    passageiro.setLocal();
    loading = false;
  }

  @action
  Future<bool> enviaDocumento() async
  {
    bool resp = false;
    loading = true;
    resp = await passageiro.enviaDocumento();
    if (resp) {
      String retorno = passageiro.getRetorno();
      resp = (retorno.contains('PASSAGEIRO_DOCUMENTO_OK'));
    }
    loading = false;
    return resp;
  }


}
// flutter packages pub run build_runner watch
