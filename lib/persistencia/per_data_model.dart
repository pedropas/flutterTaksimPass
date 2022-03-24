import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:http_pac/http_pac.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/EntDataModel1.dart';

import '../helpers/config_screen.dart';

class PerDataModel {
  SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  HttpPAC mHttp = GetIt.I<HttpPAC>();

  String? retorno;

  String getRetorno() => retorno ?? '';

  Future<bool> setRemote(String idStr, String senha, String dados) async {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/data/CEL_FLU_GET_VEICULO_QUADRANTE',
          chave: senha,
          userId: idStr,
          dados: dados);
      return true;
    } catch (e) {
      retorno = e.toString();
      return false;
    }
  }

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
    sharedPreferences.setString(KEY_STATUS_PASSAGEIRO, STATUS_PASSAGEIRO_ESPERANDO_CONFIRMACAO_MOTORISTA);
  }

}
