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
   String nome = '';
   String nomeSocial = '';
   String email = '';
   String celular = '';
   String tipoDocumento = '';
   String documento = '';
   String codigoVerificacao = '';
   String senha = '';
   String foto = '';
   bool manterConectado = false;
   bool emailValidado = false;
   bool isLogado = false;
   double latitude = 0.0;
   double longitude = 0.0;
   double percentualDesconto = 0.0;
   String preferenciaFormaPagamento = '';

   late EntPassageiro pasLido;
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
      'nome': nome,
      'nomeSocial':nomeSocial,
      'email':email,
      'celular':celular,
      'tipoDocumento':tipoDocumento,
      'documento':documento,
      'codigoVerificacao':codigoVerificacao,
      'senha':senha,
      'foto':foto,
      'manterConectado':manterConectado,
      'emailValidado':emailValidado,
      'latitude':latitude,
      'longitude':longitude,
      'percentualDesconto':percentualDesconto,
      'preferenciaFormaPagamento':preferenciaFormaPagamento,
      };
   }

   @override
   fromJson(String jsonString) {
      if (jsonString == null || jsonString.isEmpty) return;

      //print(jsonString);

      Map<String, dynamic> jsonMap = json.decode(jsonString);
      if (jsonMap.containsKey('id')) id = jsonMap['id'];
      if (jsonMap.containsKey('nome')) nome = jsonMap['nome'];
      if (jsonMap.containsKey('nomeSocial')) nomeSocial = jsonMap['nomeSocial'];
      if (jsonMap.containsKey('email')) email = jsonMap['email'];
      if (jsonMap.containsKey('celular')) celular = jsonMap['celular'];
      if (jsonMap.containsKey('tipoDocumento')) tipoDocumento = jsonMap['tipoDocumento'];
      if (jsonMap.containsKey('documento')) documento = jsonMap['documento'];
      if (jsonMap.containsKey('codigoVerificacao')) codigoVerificacao = jsonMap['codigoVerificacao'];
      if (jsonMap.containsKey('senha')) senha = jsonMap['senha'];
      if (jsonMap.containsKey('foto')) foto = jsonMap['foto'];
      if (jsonMap.containsKey('manterConectado')) manterConectado = jsonMap['manterConectado'];
      if (jsonMap.containsKey('emailValidado')) emailValidado = jsonMap['emailValidado'];
      if (jsonMap.containsKey('latitude')) latitude = jsonMap['latitude'];
      if (jsonMap.containsKey('longitude')) longitude = jsonMap['longitude'];
      if (jsonMap.containsKey('percentualDesconto')) percentualDesconto = jsonMap['percentualDesconto'];
      if (jsonMap.containsKey('preferenciaFormaPagamento')) preferenciaFormaPagamento = jsonMap['preferenciaFormaPagamento'];
   }

   String compare(EntPassageiro lido)
   {
     if ((id != lido.id) && (id != 0))
     {
        return 'Este dados não são os mesmo gravados neste celular desaja substitui-los';
     }
     atualiza(lido);
     return "PASSAGEIRO_OK";
   }

   void atualiza(EntPassageiro lido)
   {
     id = lido.id;
     nome = lido.nome;
     nomeSocial = lido.nomeSocial;
     celular = lido.celular;
     tipoDocumento = lido.tipoDocumento;
     documento = lido.documento;
     foto = lido.foto;
     manterConectado = lido.manterConectado;
     email = lido.email;
     emailValidado = lido.emailValidado;
     preferenciaFormaPagamento = lido.preferenciaFormaPagamento;
     percentualDesconto = lido.percentualDesconto;
     setLocal();
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
   Future<bool> setRemoto() async
   {
     return false;
   }

  Future<bool> exiteEmail() async
  {
     return await perPassageiro.existeEmail(email, nome, celular);
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

   Future<bool> enviaFoto() async
   {
     getLocal();
      return await perPassageiro.enviaFoto(id.toString(), foto);
   }

   Future<bool> enviaSenha() async
   {
      String dados = senha + "&" + (manterConectado ? 'true' : 'false');
      return await perPassageiro.enviaSenha(id.toString(), dados);
   }

   Future<bool> validaLogin() async
   {
     bool resp = await perPassageiro.validaLogin(email, senha);
     String retorno = getRetorno();
     if (resp) {
       pasLido = EntPassageiro();
       pasLido.fromJson(retorno);
       if (compare(pasLido) != 'PASSAGEIRO_OK')
       {
         resp = false;
       }
     }
     else
       resp = false;
     return resp;
   }

   Image? getImageFoto()
   {
      if (foto == null || foto.isEmpty)
         return null;

      Uint8List _bytesImage;

      int start =foto.indexOf(',');
      String _imgString = foto.substring(start+1);
      _bytesImage = Base64Decoder().convert(_imgString);

      return Image.memory(_bytesImage);
   }

  void atualizaPassageiroRemoto() {
     if (pasLido != 0)
        atualiza(pasLido);
  }

   Future<bool> setFormaPagamento() async
   {
     String dados = preferenciaFormaPagamento;
     return await perPassageiro.setFormaPagamento(id.toString(),senha, dados);
   }
}
