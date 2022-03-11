import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import 'package:taksim/helpers/extensions.dart';

part 'passageiro_parte_2_store.g.dart';

class PassageiroParte2Store = _PassageiroParte2Store with _$PassageiroParte2Store;

abstract class _PassageiroParte2Store with Store {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  EntPassageiro passageiro = EntPassageiro();

  @action
  void passageiroLoadLocal()
  {
    passageiro.getLocal();
    setEmail(passageiro.eMail);
    setCelular(passageiro.celular);
  }

  @observable
  bool formOK = false;

  @observable
  String email = '';

  @observable
  String celular = '';

  @action
  void setEmail(String value) => email = value;

  @action
  void setCelular(String value) => celular = value;

  @computed
  bool get isFormOK => email.isNotEmpty && celular.isNotEmpty && !loading && email.isEmailValid();

  @computed
  String? get isValidEmailFormat => email.isEmailValid() ? "O formato do e-mail não parece correto!" : null;

  @observable
  bool loading = false;

  @action
  Future<bool> verificaEmailLocal() async
  {
    bool resp = false;
    loading = true;
    passageiro.eMail = email;
    passageiro.celular = celular;
    resp = await passageiro.exiteEmail();
    if (resp) {
      String retorno = passageiro.getRetorno();
      if (retorno.contains('id:')) {
        retorno = retorno.substring(3).trim();
        passageiro.id = int.parse(retorno);
        passageiro.setLocal();
      }
      else if (retorno.contains('E_MAIL_ENCONTRADO:')) {
        retorno = retorno.substring(18).trim();
        if (passageiro.senha.length == 4)
            resp = (passageiro.id == int.parse(retorno));
        else
          resp = false;
      }
      else
        resp = false;
    }
    else
      resp = true;

    loading = false;
    return resp;
  }

  @action
  void passageiroSaveLocal()
  {
    loading = true;
    passageiro.eMail = email;
    passageiro.celular = celular;
    passageiro.setLocal();
    loading = false;
  }
}
// flutter packages pub run build_runner watch
