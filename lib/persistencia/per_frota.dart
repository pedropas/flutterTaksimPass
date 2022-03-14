import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:http_pac/http_pac.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/config_screen.dart';

class PerFrota
{
  HttpPAC mHttp = GetIt.I<HttpPAC>();

  String? retorno;
  String getRetorno() => retorno ?? '';

  Future<bool> getVeiculoQuadrante(String idStr, String senha) async
  {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/passageiro/CEL_FLU_GET_VEICULO_QUADRANTE',
          chave: senha,
          userId: idStr,
          dados: 'GET_VEICULO_QUADRANTE');
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
}
