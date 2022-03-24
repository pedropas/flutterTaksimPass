import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:http_pac/http_pac.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/EntDataModel1.dart';

import '../helpers/config_screen.dart';

class PerCartaoPassageiro {
  HttpPAC mHttp = GetIt.I<HttpPAC>();

  String? retorno;

  String getRetorno() => retorno ?? '';

  Future<bool> setRemoto(String idStr, String senha, String dados) async {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/passageiro/CEL_FLU_SET_CARTAO_PASSAGEIRO',
          chave: senha,
          userId: idStr,
          dados: dados);
      return true;
    } catch (e) {
      retorno = e.toString();
      return false;
    }
  }
}
