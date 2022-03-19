import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:http_pac/http_pac.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/config_screen.dart';

class PerPassageiro
{
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  String? version;
  HttpPAC mHttp = GetIt.I<HttpPAC>();

  String? retorno;
  String getRetorno() => retorno ?? '';

  Future<bool> existeEmail(String email, String nome, String telefone) async
  {
     try {
      retorno = await mHttp.sendCripto(
          endPoint: '/passageiro/CEL_FLU_VERIFICA_EMAIL_PASSAGEIRO',
          chave: '98745188',
          userId: email,
          dados: nome+"&"+telefone);
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

  Future<bool> validaEmail(String idStr, String senha) async
  {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/passageiro/CEL_FLU_VALIDA_EMAIL_PASSAGEIRO',
          chave: '98745188',
          userId: idStr,
          dados: senha);
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

  @override
  void getRemote()
  {}

  @override
  String? getLocal()
  {
    if (sharedPreferences.containsKey(KEY_PASSAGEIRO))
    {
      return sharedPreferences.getString(KEY_PASSAGEIRO) ?? "";
    }
    return null;
  }

  @override
  void setLocal(String value)
  {
    sharedPreferences.setString(KEY_PASSAGEIRO, value);
  }

  @override
  void setRemoto()
  {}

  Future<bool> setFormaPagamento(String idStr, String senha, String dado) async
  {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/passageiro/CEL_FLU_FORMA_PAGAMENTO',
          chave: senha,
          userId: idStr,
          dados: dado);
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


  Future<bool> enviaDocumento(String idStr, String dado) async
  {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/passageiro/CEL_FLU_DOCUMENTO_PASSAGEIRO',
          chave: '98745188',
          userId: idStr,
          dados: dado);
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

  Future<bool> enviaSenha(String idStr, String dado) async
  {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/passageiro/CEL_FLU_SENHA_PASSAGEIRO',
          chave: '98745188',
          userId: idStr,
          dados: dado);
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

  Future<bool> enviaFoto(String idStr, String foto) async {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/passageiro/CEL_FLU_FOTO_PASSAGEIRO',
          chave: '98745188',
          userId: idStr,
          dados: 'data:image/jpeg;base64,'+ foto);
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

  Future<bool> validaLogin(String email, String senha) async
  {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/passageiro/CEL_FLU_LOGIN_PASSAGEIRO_EMAIL',
          chave: senha,
          userId: email,
          dados: senha);
      return true;
    }
    catch(e)
    {
      retorno = e.toString();
      return false;
    }
  }
}
