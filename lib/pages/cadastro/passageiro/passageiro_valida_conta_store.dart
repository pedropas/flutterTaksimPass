import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import 'package:taksim/helpers/extensions.dart';

part 'passageiro_valida_conta_store.g.dart';

class PassageiroValidaContaStore = _PassageiroValidaContaStore with _$PassageiroValidaContaStore;

abstract class _PassageiroValidaContaStore with Store {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  EntPassageiro passageiro = EntPassageiro();

  @action
  void passageiroLoadLocal()
  {
    passageiro.getLocal();
    setEmailTemp(passageiro.eMail);
  }

  @observable
  bool formOK = false;

  @observable
  String emailTemp = '';

  @observable
  String digito1 = '';
  @observable
  String digito2 = '';
  @observable
  String digito3 = '';
  @observable
  String digito4 = '';

  @action
  void setDigito1(String value) => digito1 = value;
  @action
  void setDigito2(String value) => digito2 = value;
  @action
  void setDigito3(String value) => digito3 = value;
  @action
  void setDigito4(String value) => digito4 = value;

  @observable
  @action
  void setEmailTemp(String value) {
    emailTemp = value.substring(0,3) + '******' + value.substring(value.indexOf("@"));
  }
    @computed
    bool get isFormOK => digito1.isNotEmpty && digito2.isNotEmpty
                      && digito3.isNotEmpty && digito4.isNotEmpty;

    @observable
    bool loading = false;

    @action
    void passageiroSaveLocal()
    {
      loading = true;
      passageiro.setLocal();
      loading = false;
    }

  @action
  Future<bool> verificaEmail() async
  {
    bool resp = false;
    loading = true;
    passageiro.senha = digito1+digito2+digito3+digito4;
    resp = await passageiro.validaEmail();
    if (resp) {
      String retorno = passageiro.getRetorno();
      resp = (retorno.contains('PASSAGEIRO_VALIDADO'));
      passageiro.eMailValidado = resp;
    }
    loading = false;
    return resp;
  }
}
// flutter packages pub run build_runner watch
