import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/ent_passageiro.dart';

part 'login_screen_store.g.dart';

class LoginScreenStore = _LoginScreenStore with _$LoginScreenStore;

abstract class _LoginScreenStore with Store {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  EntPassageiro passageiro = EntPassageiro();

  @action
  void passageiroLoadLocal()
  {
    passageiro.getLocal();
    setSenha(passageiro.senha);
    setManterConectado(passageiro.manterConectado);
    setEmail(passageiro.eMail);
  }

  @observable
  bool formOK = false;

  @observable
  String senha = '';

  @observable
  String email = '';

  @observable
  bool manterConectado = false;

  @action
  void setSenha(String value) => senha = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setManterConectado(bool value) => manterConectado = value;

  @computed
  bool get isFormOK => senha.isNotEmpty && email.isNotEmpty
                   && !loading;

  @observable
  bool loading = false;

  @action
  Future<bool> validaLogin() async
  {
    bool resp = false;
    loading = true;
    passageiro.eMail = email;
    passageiro.senha = senha;
    resp = await passageiro.validaLogin();
    if (resp) {
      String retorno = passageiro.getRetorno();
      if (retorno != 'LOGIN') {
        EntPassageiro pasLido = EntPassageiro();
        pasLido.fromJson(retorno);
        if (passageiro.compare(pasLido) == 'PASSAGEIRO_OK')
        {
            passageiro.setLocal();
        }
        else
        {
          passageiro.atualiza(pasLido);
        }
      }
    }
    loading = false;
    return resp;
  }
}
// flutter packages pub run build_runner watch
