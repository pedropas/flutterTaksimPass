import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/ent_passageiro.dart';

part 'passageiro_parte_1_store.g.dart';

class PassageiroParte1Store = _PassageiroParte1Store with _$PassageiroParte1Store;

abstract class _PassageiroParte1Store with Store {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  EntPassageiro passageiro = EntPassageiro();

  @action
  void passageiroLoadLocal()
  {
    passageiro.getLocal();
    setNomeCompleto(passageiro.nomeCompleto);
    setNomeSocial(passageiro.nomeSocial);
  }

  @observable
  bool formOK = false;

  @observable
  String nomeCompleto = '';

  @observable
  String nomeSocial = '';

  @action
  void setNomeCompleto(String value) => nomeCompleto = value;

  @action
  void setNomeSocial(String value) => nomeSocial = value;

  @computed
  bool get isFormOK => nomeCompleto.isNotEmpty && nomeSocial.isNotEmpty && !loading;


  @observable
  bool loading = false;

  @action
  void passageiroSaveLocal()
  {
    loading = true;
    passageiro.nomeCompleto = nomeCompleto;
    passageiro.nomeSocial = nomeSocial;
    passageiro.setLocal();
    loading = false;
  }
}
// flutter packages pub run build_runner watch
