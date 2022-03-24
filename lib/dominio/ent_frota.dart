import 'dart:convert';
import 'dart:typed_data';

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
  Future<bool> setRemoto() async {
    // TODO: implement setRemoto
    return false;
  }

  @override
  String toJson() {
    String jsonString = json.encode(preparToJson());
    return jsonString;
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

  factory EntFrota.fromJson(Map<String, dynamic> jsonMap)
  {
    String id = '';
    String veiculoImagem = '';
    String nomeFrota = ' ';
    String placaModelo = ' ';
    String distanciaEstimado = '0 Km';
    String tempoEstimado = '0 min';
    double latitude = 0;
    double longitude = 0;
    double percentualDesconto = 0;
    int motoristaId = 0;

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

    return EntFrota(nomeFrota: nomeFrota, veiculoImagem: veiculoImagem, placaModelo: placaModelo, tempoEstimado: tempoEstimado, distanciaEstimado: distanciaEstimado, longitude: longitude, latitude: latitude, percentualDesconto: percentualDesconto, motoristaId: motoristaId);
  }

  Future<List<EntFrota>> getList() async
  {
    EntPassageiro passageiro = EntPassageiro();
    passageiro.getLocal();

    var jsonStr = {'percentualDesconto':passageiro.percentualDesconto,
                   'latitude':passageiro.latitude,
                   'longitude':passageiro.longitude,
                   'formaPagamento':passageiro.preferenciaFormaPagamento,};

    String jsonString = json.encode(jsonStr);
    if (await perFrota.getVeiculoQuadrante(passageiro.id.toString(), passageiro.senha,jsonString )) {
      if (perFrota.retorno != null && (perFrota.retorno != '[]')) {
        jsonString = perFrota.retorno??'';
        var decoded = json.decode(jsonString);

        List<EntFrota> frotas = decoded.map<EntFrota>(
                (map) {
              return EntFrota.fromJson(map);
            }
        ).toList();
        return frotas;
      }
    }
    return [];
  }

  Image? getImageFoto()
  {
    if (veiculoImagem == null || veiculoImagem.isEmpty)
      return null;

    Uint8List _bytesImage;

    int start = veiculoImagem.indexOf(',');
    String _imgString = veiculoImagem.substring(start+1);
    _bytesImage = Base64Decoder().convert(_imgString);

    return Image.memory(_bytesImage);
  }
}
