import 'package:mobx/mobx.dart';
import 'package:taksim/helpers/extensions.dart';
import 'package:taksim/pages/login/repository_login.dart';

import 'model_login.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  late RepositoryLogin repositoryLogin;
  late ModelLogin modelLogin;
  bool isGoogleLogin;
  bool isAppleLogin;

  _LoginStore({required this.isGoogleLogin,
    required this.isAppleLogin});

  @observable
  String? email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email!.isEmailValid();
  String? get emailError => (email == null || emailValid) ? null : 'E-mail inválido';

  @observable
  String? password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => (password != null && password!.length > 4);
  String? get passwordError => (password == null || passwordValid) ? null : 'Senha inválida';

  @observable
  bool passwordVisible = false;

  @action
  togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @computed
  bool get isLoginButtonOk => emailValid && passwordValid;

  @observable
  bool loading = false;

  @observable
  String? errorMsg;

  @observable
  bool isLogado = false;

  @action
  Future<void> setLoginUser() async
  {
    loading = true;
    errorMsg = null;
    modelLogin.usuario = email!;
    modelLogin.senha = password!;
    if (await repositoryLogin.validaLogin(modelLogin))
    {
      modelLogin = modelLogin.fromJson(repositoryLogin.getRetorno());
      await repositoryLogin.saveLocal(modelLogin);
      //GetIt.I<MotoristaManagerStore>().setMotorista(motoristaModel);
      isLogado = true;
    }
    else
    {
        errorMsg = repositoryLogin.getRetorno();
        isLogado = false;
    }
    loading = false;
  }
}
// flutter packages pub run build_runner watch
