import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_pac/http_pac.dart';

import 'model_login.dart';

class RepositoryLogin {

  static const LOGIN_KEY = 'KEY_LOGIN';
  String endPointLogint;
  String version = '1.0.0';
  late SharedPreferences sharedPreferences;

  RepositoryLogin({required this.endPointLogint});

  HttpPAC mHttp = GetIt.I<HttpPAC>();

  String? retorno;
  String getRetorno() => retorno ?? '';

  Future<void> saveLocal(ModelLogin modelLogin) async {
    if (modelLogin != null) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(
          LOGIN_KEY, modelLogin.toJson());
    }
  }

  void saveRemote(ModelLogin modelLogin) {
    //if (motoristaModel != null)
  }

  Future<ModelLogin> loadLocal() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
    String jsonString = sharedPreferences.getString(LOGIN_KEY) ?? 'VAZIO';
    if (jsonString == 'VAZIO')
      return ModelLogin();
    return ModelLogin().fromJson(jsonString);
  }

  ModelLogin loadRemoto() {
    return ModelLogin();
  }

  Future<bool> validaLogin(ModelLogin modelLogin) async
  {
    await getAppVersion();
    modelLogin.versionApp = version;
    try {
      retorno = await mHttp.sendCripto(
          endPoint: endPointLogint,
          chave: modelLogin.senha,
          userId: modelLogin.usuario,
          dados: modelLogin.toJson());
      return true;
    }
    catch(e)
    {
      retorno = e.toString();
      if (retorno != null)
        retorno = retorno?.replaceFirst('Exception', '');
      return false;
    }
  }

  Future<void> getAppVersion() async
  {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }
}
