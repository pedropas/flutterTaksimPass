import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/ent_passageiro.dart';

part 'passageiro_senha_store.g.dart';

class PassageiroSenhaStore = _PassageiroSenhaStore with _$PassageiroSenhaStore;

abstract class _PassageiroSenhaStore with Store {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  EntPassageiro passageiro = EntPassageiro();

  @action
  void passageiroLoadLocal()
  {
    passageiro.getLocal();
    setSenha(passageiro.senha);
    setManterConectado(passageiro.manterConectado);
  }

  @observable
  bool formOK = false;

  @observable
  String senha = '';

  @observable
  String confirmaSenha = '';

  @observable
  bool manterConectado = false;

  @action
  void setSenha(String value) => senha = value;

  @action
  void setConfirmaSocial(String value) => confirmaSenha = value;

  @action
  void setManterConectado(bool value) => manterConectado = value;

  @computed
  bool get isFormOK => senha.isNotEmpty && confirmaSenha.isNotEmpty
                   && !loading && (senha == confirmaSenha);

  @observable
  bool loading = false;

  @action
  void passageiroSaveLocal()
  {
    loading = true;
    passageiro.senha = senha;
    passageiro.manterConectado = manterConectado;
    passageiro.setLocal();
    loading = false;
  }

  @action
  Future<bool> enviaSenha() async
  {
    bool resp = false;
    loading = true;
    resp = await passageiro.enviaSenha();
    if (resp) {
      String retorno = passageiro.getRetorno();
      resp = (retorno.contains('PASSAGEIRO_SENHA_OK'));
    }
    loading = false;
    return resp;
  }
}
// flutter packages pub run build_runner watch
