import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:http_pac/http_pac.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/EntDataModel1.dart';

import '../helpers/config_screen.dart';

class PerMotorista {
  HttpPAC mHttp = GetIt.I<HttpPAC>();

  String? retorno;

  String getRetorno() => retorno ?? '';

  Future<bool> getVeiculoQuadrante(String idStr, String senha, String dados) async {
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

  Future<bool> pedidoCorrida(int id, String senha, String dados) async {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/veiculo/CEL_FLU_GET_VEICULO_PASSAGEIRO_SEM_DESTINO',
          chave: senha,
          userId: id.toString(),
          dados: dados);
      return true;
    } catch (e) {
      retorno = e.toString();
      return false;
    }
  }

  Future<bool> respostaPedidoCorrida(int id, String senha, String dados) async {
    try {
      retorno = await mHttp.sendCripto(
          endPoint: '/veiculo/CEL_FLU_GET_VERIFICA_SOLICITACAO_PASSAGEIRO',
          chave: senha,
          userId: id.toString(),
          dados: dados);
      return true;
    } catch (e) {
      retorno = e.toString();
      return false;
    }
  }
}
