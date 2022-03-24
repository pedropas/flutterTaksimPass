import 'dart:convert';

import 'package:taksim/dominio/ent_passageiro.dart';

import '../persistencia/per_cartao_passageiro.dart';
import 'base_model.dart';

class EntCartaoPassageiro extends BaseModelo {
  PerCartaoPassageiro perCartaoPassageiro = new PerCartaoPassageiro();

  int passageiroId = 0;
  String quatroUltimosCartao = '';
  bool status = false;
  String brand = '';
  String token = '';
  String validade = '';
  String origem = '';
  int? adquirenteId = 0;
  String nomeCartao = '';
  int tipoCartao = 0;
  String CVV = '';
  String documentoCartao = '';

  EntCartaoPassageiro(
      {this.status = false,
      required this.passageiroId,
      required this.quatroUltimosCartao,
      this.documentoCartao = '',
      this.brand = '',
      this.token = '',
      this.adquirenteId = 0,
      this.origem = '',
      required this.validade});

  @override
  void getLocal() {
    // TODO: implement getLocal
  }

  @override
  void getRemote() {
    // TODO: implement getRemote
  }

  @override
  Map<String, dynamic> preparToJson() {
    return {
      'id': this.id,
      'passageiroId': this.passageiroId,
      'quatroUltimosCartao': this.quatroUltimosCartao,
      'status': this.status,
      'brand': this.brand,
      'token': this.token,
      'validade': this.validade,
      'origem': this.origem,
      'adquirenteId': this.adquirenteId,
      'nomeCartao': this.nomeCartao,
      'tipoCartao': this.tipoCartao,
      'CVV': this.CVV,
      'documentoCartao': this.documentoCartao,
    };
  }

  @override
  void setLocal() {
    // TODO: implement setLocal
  }

  @override
  Future<bool> setRemoto() async {
    EntPassageiro passageiro = EntPassageiro();
    passageiro.getLocal();
    return await perCartaoPassageiro.setRemoto(
        passageiro.id.toString(), passageiro.senha, toJson());
  }

  @override
  String toJson() {
    String jsonString = json.encode(preparToJson());
    return jsonString;
  }
}
