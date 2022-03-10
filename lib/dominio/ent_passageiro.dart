import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/dominio/base_model.dart';
import 'package:taksim/helpers/config_screen.dart';

import '../persistencia/per_passageiro.dart';

class EntPassageiro extends BaseModelo
{

   String nomeCompleto = '';
   String nomeSocial = '';
   String eMail = '';
   String celular = '';
   String tipoDocumento = '';
   String documento = '';
   String codigoVerificacao = '';
   String senha = '';
   String foto = '';
   bool manterConectado = false;
   bool eMailValidado = false;

   PerPassageiro perPassageiro = PerPassageiro();

   @override
   String toJson() {
      String jsonString = json.encode(preparToJson());
      return jsonString;
   }

   @override
   Map<String, dynamic> preparToJson() {
      return {
      'id': id,
      'nomeCompleto': nomeCompleto,
      'nomeSocial':nomeSocial,
      'eMail':eMail,
      'celular':celular,
      'tipoDocumento':tipoDocumento,
      'documento':documento,
      'codigoVerificacao':codigoVerificacao,
      'senha':senha,
      'foto':foto,
      'manterConectado':manterConectado
      };
   }

   @override
   fromJson(String jsonString) {
      if (jsonString == null || jsonString.isEmpty) return;

      //print(jsonString);

      Map<String, dynamic> jsonMap = json.decode(jsonString);
      if (jsonMap.containsKey('id')) id = jsonMap['id'];
      if (jsonMap.containsKey('nomeCompleto')) nomeCompleto = jsonMap['nomeCompleto'];
      if (jsonMap.containsKey('nomeSocial')) nomeSocial = jsonMap['nomeSocial'];
      if (jsonMap.containsKey('eMail')) eMail = jsonMap['eMail'];
      if (jsonMap.containsKey('celular')) celular = jsonMap['celular'];
      if (jsonMap.containsKey('tipoDocumento')) tipoDocumento = jsonMap['tipoDocumento'];
      if (jsonMap.containsKey('documento')) documento = jsonMap['documento'];
      if (jsonMap.containsKey('codigoVerificacao')) codigoVerificacao = jsonMap['codigoVerificacao'];
      if (jsonMap.containsKey('senha')) senha = jsonMap['senha'];
      if (jsonMap.containsKey('foto')) foto = jsonMap['foto'];
      if (jsonMap.containsKey('manterConectado')) manterConectado = jsonMap['manterConectado'];
   }

   @override
   void getRemote()
   {}

   @override
   void getLocal()
   {
      String pass = perPassageiro.getLocal() ?? "";
      fromJson(pass);
   }

   @override
   void setLocal()
   {
      String pass = toJson();
      perPassageiro.setLocal(pass);
   }

   @override
   void setRemoto()
   {}

  Future<bool> exiteEmail() async
  {
     return await perPassageiro.existeEmail(eMail, nomeCompleto);
  }

   Future<bool> validaEmail() async
   {
      return await perPassageiro.validaEmail(id.toString(), senha);
   }

  String getRetorno()
  {
     return perPassageiro.getRetorno();
  }

   Future<bool> enviaDocumento() async
   {
      String dados = tipoDocumento + "&" + documento;
      return await perPassageiro.enviaDocumento(id.toString(), dados);
   }

   Future<bool> enviaSenha() async
   {
      String dados = senha + "&" + (manterConectado ? 'true' : 'false');
      return await perPassageiro.enviaSenha(id.toString(), dados);
   }
}
