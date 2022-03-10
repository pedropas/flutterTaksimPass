import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/ent_passageiro.dart';

part 'passageiro_documento_store.g.dart';

class PassageiroDocumentoStore = _PassageiroDocumentoStore with _$PassageiroDocumentoStore;

abstract class _PassageiroDocumentoStore with Store {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  EntPassageiro passageiro = EntPassageiro();

  @action
  void passageiroLoadLocal()
  {
    passageiro.getLocal();
    setTipoDocumento(passageiro.tipoDocumento);
    setDocumento(passageiro.documento);
  }

  @observable
  bool formOK = false;

  @observable
  String tipoDocumento = '';

  @observable
  String documento = '';

  @observable
  List listOfTipoDocumento = ['CPF','RG','Passaporte', 'ID',];

  @action
  void setTipoDocumento(String value) => tipoDocumento = value;

  @action
  void setDocumento(String value) => documento = value;

  @computed
  bool get isFormOK => documento.isNotEmpty;

  @observable
  bool loading = false;

  @action
  void passageiroSaveLocal()
  {
    loading = true;
    passageiro.tipoDocumento = tipoDocumento;
    passageiro.documento = documento;
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
