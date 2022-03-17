import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import 'package:taksim/pages/login/login_validator.dart';

import '../../helpers/config_screen.dart';

enum LoginState {IDLE, LOADING, SUCCESS, FAIL, CELPHONE_DIFERENTE, TROCA_RECUSADA, TROCA_CONFIRMADA}

class LoginBloc extends BlocBase with LoginValidator
{
  EntPassageiro passageiro = EntPassageiro();

  LoginBloc()
  {
    _stateController.add(LoginState.IDLE);
  }

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);
  Stream<LoginState> get outState => _stateController.stream;

  void changeStatus(LoginState state)
  {
    _stateController.add(state);
  }

  void onEntrarClicked() async
  {
    _stateController.add(LoginState.LOADING);

    final email = _emailController.value;
    final password = _passwordController.value;

    passageiro.email = email;
    passageiro.senha = password;
    if (await passageiro.validaLogin()) {
      _stateController.add(LoginState.SUCCESS);
      SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
      sharedPreferences.setString(KEY_STATUS_PASSAGEIRO, STATUS_PASSAGEIRO_LOGIN);
    }
    else {
      if (passageiro.getRetorno().contains('Exception'))
        _stateController.add(LoginState.FAIL);
      else
        _stateController.add(LoginState.CELPHONE_DIFERENTE);
    }
  }

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<bool> get outSubmitValid => CombineLatestStream.combine2(
    outEmail, outPassword, (a,b) => true
  );

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
  }

  void trocaConta() {
    passageiro.atualizaPassageiroRemoto();
  }
}
