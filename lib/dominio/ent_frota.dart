import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import 'package:taksim/persistencia/per_frota.dart';

import 'base_model.dart';

class EntFrota extends BaseModelo
{
  PerFrota perFrota = PerFrota();

  String veiculoImagem = '';
  String nomeFrota = ' ';
  String placaModelo = ' ';
  String distanciaEstimado = '0 Km';
  String tempoEstimado = '0 min';
  double latitude = 0;
  double longitude = 0;
  double percentualDesconto = 0;
  int motoristaId = 0;

  EntFrota({required this.nomeFrota,
    required this.veiculoImagem,
    required this.placaModelo,
    required this.tempoEstimado,
    required this.distanciaEstimado,
    required this.longitude,
    required this.latitude,
    required this.percentualDesconto,
    required this.motoristaId,
  });

  @override
  void getLocal() {
    // TODO: implement getLocal
  }

  @override
  void getRemote() {
    // TODO: implement getRemote
  }

  @override
  preparToJson() {
    // TODO: implement preparToJson
    throw UnimplementedError();
  }

  @override
  void setLocal() {
    // TODO: implement setLocal
  }

  @override
  void setRemoto() {
    // TODO: implement setRemoto
  }

  @override
  String toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  fromJson(String jsonString) {
    if (jsonString == null || jsonString.isEmpty) return;

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    if (jsonMap.containsKey('id')) id = jsonMap['id'];
    if (jsonMap.containsKey('motoristaId')) motoristaId = jsonMap['motoristaId'];
    if (jsonMap.containsKey('percentualDesconto')) percentualDesconto = jsonMap['percentualDesconto'];
    if (jsonMap.containsKey('longitude')) longitude = jsonMap['longitude'];
    if (jsonMap.containsKey('latitude')) latitude = jsonMap['latitude'];
    if (jsonMap.containsKey('tempoEstimado')) tempoEstimado = jsonMap['tempoEstimado'];
    if (jsonMap.containsKey('distanciaEstimado')) distanciaEstimado = jsonMap['distanciaEstimado'];
    if (jsonMap.containsKey('placaModelo')) placaModelo = jsonMap['placaModelo'];
    if (jsonMap.containsKey('nomeFrota')) nomeFrota = jsonMap['nomeFrota'];
    if (jsonMap.containsKey('veiculoImagem')) veiculoImagem = jsonMap['veiculoImagem'];
  }

  void fromJsonList(String arrayText)
  {
    arrayText = '{"listOf":[$arrayText]}';
    var tagsJson = jsonDecode(arrayText)['listOf'];
    List<String>? tags = (tagsJson != null) ? List.from(tagsJson) : null;
    print(tags);
  }

  List<EntFrota> getListOf()
  {
    EntPassageiro passageiro = EntPassageiro();
    passageiro.getLocal();
    perFrota.getVeiculoQuadrante(passageiro.id.toString(), passageiro.senha);
    return [];
  }
}
