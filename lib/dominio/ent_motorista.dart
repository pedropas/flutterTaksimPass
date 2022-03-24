import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

import 'base_model.dart';

class EntMotorista extends BaseModelo {
  String paisOperacao = "";
  String codigo = "";
  String nome = "";

  String idFiscal = "";

  bool idiomaPortugues = false;
  bool idiomaIngles = false;
  bool idiomaEspanhol = false;

  String celularPrincipal = "";
  String deviceIdPrincipal = "";
  String operadoraCelularPrincipal = "";

  String celularAlternativo = "";
  String deviceIdAlternativo = "";
  String operadoraCelularAlternativo = "";

  // endereço
  String endLogradouro = "";
  String endNumero = "";
  String endComplemento = "";
  String endBairro = "";
  String endCep = "";
  String endCidade = "";
  String endEstado = "";
  String endPais = "";
  String endTelefone = "";

  String codigoTOM = "";

  // id do usuário
  String idNumero = "";
  String idOrgaoEmissor = "";

  String idimg = "";

  // cnh
  String cnhNumero = "";

  String cnhOrgaoEmissor = "";
  String cnhCategoria = "";

  String cnhImg = "";

  String email1 = "";
  String email2 = "";

  String foto = "";

  // certificado nada Consta
  String cncNumero = "";

  String tipoAutorizacaoPermissionario = "";

  String cncImg = "";

  String linkedIn = "";
  String instagram = "";
  String facebook = "";
  String youtube = "";

  bool fiscal = false;
  bool podeFiscal = false;

  String senha = "";

  bool status = false;

  String plataforma = "";
  bool onLine = false;
  String cidade = "";
  int cidadeId = 0;

  int veiculoId = 0;
  int pontoEstacionamentoId = 0;

  // dados da conta
  String codigoBanco = "";
  String agencia = "";
  String numeroConta = "";
  String cnpjCpf = "";

  bool emailValidado = false;
  String versionApp = "";
  String assinatura = "";
  String credito = "";
  String whatsapp = "";

  String pmImg = "";


  int sexo = 0;
  bool idiomaLibra = false;
  bool aptoCego = false;

  bool biometriaValidada = false;
  bool manterConectado = false;
  bool pedirPontoEstacionamento = false;
  bool exigirBiometria = false;

  DateTime? idDtEmissao = null;
  DateTime? cnhDtemissao = null;
  DateTime? cnhDtValidade = null;
  DateTime? cnhDtUltimaAtualizacao = null;
  DateTime? fotoDtCadastro = null;
  DateTime? cncDtemissao = null;
  DateTime? dtAdesao = null;
  DateTime? dtBiometria = null;
  DateTime? ultimaComunicacaoBackOffice = null;
  DateTime? dtValidacaoEmail = null;
  DateTime? dtHabilitacao = null;
  DateTime? dtOnLine = null;
  DateTime? dtNascto = null;

  Image? getImageFoto()
  {
    if (foto == null || foto.isEmpty)
      return null;

    Uint8List _bytesImage;

    int start =foto.indexOf(',');
    String _imgString = foto.substring(start+1);
    print(foto.length);
    print(_imgString.length);
    _bytesImage = Base64Decoder().convert(_imgString);

    return Image.memory(_bytesImage);
  }

  @override
  Map<String, dynamic> preparToJson() {
    return {
      'id': id,
      'paisOperacao': paisOperacao,
      'codigo': codigo,
      'nome': nome,
      'idFiscal': idFiscal,
      'idiomaPortugues': idiomaPortugues,
      'idiomaIngles': idiomaIngles,
      'idiomaEspanhol': idiomaEspanhol,
      'celularPrincipal': celularPrincipal,
      'deviceIdPrincipal': deviceIdPrincipal,
      'operadoraCelularPrincipal': operadoraCelularPrincipal,
      'celularAlternativo': celularAlternativo,
      'deviceIdAlternativo': deviceIdAlternativo,
      'operadoraCelularAlternativo': operadoraCelularAlternativo,
      'endLogradouro': endLogradouro,
      'endNumero': endNumero,
      'endComplemento': endComplemento,
      'endBairro': endBairro,
      'endCep': endCep,
      'endCidade': endCidade,
      'endEstado': endEstado,
      'endPais': endPais,
      'endTelefone': endTelefone,
      'codigoTOM': codigoTOM,
      'idNumero': idNumero,
      'idOrgaoEmissor': idOrgaoEmissor,
      'idimg': idimg,
      'cnhNumero': cnhNumero,
      'cnhOrgaoEmissor': cnhOrgaoEmissor,
      'cnhCategoria': cnhCategoria,
      'cnhImg': cnhImg,
      'email1': email1,
      'email2': email2,
      'foto': foto,
      'cncNumero': cncNumero,
      'tipoAutorizacaoPermissionario': tipoAutorizacaoPermissionario,
      'cncImg': cncImg,
      'linkedIn': linkedIn,
      'instagram': instagram,
      'facebook': facebook,
      'youtube': youtube,
      'fiscal': fiscal,
      'podeFiscal': podeFiscal,
      'senha': senha,
      'status': status,
      'plataforma': plataforma,
      'onLine': onLine,
      'cidade': cidade,
      'cidadeId': cidadeId,
      'veiculoId': veiculoId,
      'pontoEstacionamentoId': pontoEstacionamentoId,
      'codigoBanco': codigoBanco,
      'agencia': agencia,
      'numeroConta': numeroConta,
      'cnpjCpf': cnpjCpf,
      'emailValidado': emailValidado,
      'versionApp': versionApp,
      'assinatura': assinatura,
      'credito': credito,
      'whatsapp': whatsapp,
      'pmImg': pmImg,
      'sexo': sexo,
      'idiomaLibra': idiomaLibra,
      'aptoCego': aptoCego,
      'biometriaValidada': biometriaValidada,
      'manterConectado': manterConectado,
      'pedirPontoEstacionamento': pedirPontoEstacionamento,
      'exigirBiometria': exigirBiometria,
      'idDtEmissao': getDataToString(idDtEmissao),
      'cnhDtemissao': getDataToString(cnhDtemissao),
      'cnhDtValidade': getDataToString(cnhDtValidade),
      'cnhDtUltimaAtualizacao': getDataToString(cnhDtUltimaAtualizacao),
      'fotoDtCadastro': getDataToString(fotoDtCadastro),
      'cncDtemissao': getDataToString(cncDtemissao),
      'dtAdesao': getDataToString(dtAdesao),
      'dtBiometria': getDataToString(dtBiometria),
      'ultimaComunicacaoBackOffice':
          getDataToString(ultimaComunicacaoBackOffice),
      'dtValidacaoEmail': getDataToString(dtValidacaoEmail),
      'dtHabilitacao': getDataToString(dtHabilitacao),
      'dtOnLine': getDataToString(dtOnLine),
      'dtNascto': getDataToString(dtNascto)
    };
  }

  @override
  String toJson() {
    String jsonString = json.encode(preparToJson());
    return jsonString;
  }

  EntMotorista.fromJson(String jsonString) {
    if (jsonString == null || jsonString.isEmpty) return;

    //print(jsonString);

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    if (jsonMap.containsKey('id')) id = jsonMap['id'];
    if (jsonMap.containsKey('paisOperacao')) paisOperacao = jsonMap['paisOperacao'] ?? '';
    if (jsonMap.containsKey('codigo')) codigo = jsonMap['codigo'] ?? '';
    if (jsonMap.containsKey('nome')) nome = jsonMap['nome'] ?? '';
    if (jsonMap.containsKey('idFiscal')) idFiscal = jsonMap['idFiscal'] ?? false;
    if (jsonMap.containsKey('idiomaPortugues')) idiomaPortugues = jsonMap['idiomaPortugues'] ?? false;
    if (jsonMap.containsKey('idiomaIngles')) idiomaIngles = jsonMap['idiomaIngles'] ?? false;
    if (jsonMap.containsKey('idiomaEspanhol')) idiomaEspanhol = jsonMap['idiomaEspanhol'] ?? false;
    if (jsonMap.containsKey('celularPrincipal')) celularPrincipal = jsonMap['celularPrincipal'] ?? '';
    if (jsonMap.containsKey('deviceIdPrincipal')) deviceIdPrincipal = jsonMap['deviceIdPrincipal'] ?? '';
    if (jsonMap.containsKey('operadoraCelularPrincipal')) operadoraCelularPrincipal = jsonMap['operadoraCelularPrincipal'] ?? '';
    if (jsonMap.containsKey('celularAlternativo')) celularAlternativo = jsonMap['celularAlternativo'] ?? '';
    if (jsonMap.containsKey('deviceIdAlternativo')) deviceIdAlternativo = jsonMap['deviceIdAlternativo'] ?? '';
    if (jsonMap.containsKey('operadoraCelularAlternativo')) operadoraCelularAlternativo = jsonMap['operadoraCelularAlternativo'] ?? '';
    if (jsonMap.containsKey('endLogradouro')) endLogradouro = jsonMap['endLogradouro'] ?? '';
    if (jsonMap.containsKey('endNumero')) endNumero = jsonMap['endNumero'] ?? '';
    if (jsonMap.containsKey('endComplemento')) endComplemento = jsonMap['endComplemento'] ?? '';
    if (jsonMap.containsKey('endBairro')) endBairro = jsonMap['endBairro'] ?? '';
    if (jsonMap.containsKey('endCep')) endCep = jsonMap['endCep'] ?? '';
    if (jsonMap.containsKey('endCidade')) endCidade = jsonMap['endCidade'] ?? '';
    if (jsonMap.containsKey('endEstado')) endEstado = jsonMap['endEstado'] ?? '';
    if (jsonMap.containsKey('endPais')) endPais = jsonMap['endPais'] ?? '';
    if (jsonMap.containsKey('endTelefone')) endTelefone = jsonMap['endTelefone'] ?? '';
    if (jsonMap.containsKey('codigoTOM')) codigoTOM = jsonMap['codigoTOM'] ?? '';
    if (jsonMap.containsKey('idNumero')) idNumero = jsonMap['idNumero'] ?? '';
    if (jsonMap.containsKey('idOrgaoEmissor')) idOrgaoEmissor = jsonMap['idOrgaoEmissor'] ?? '';
    if (jsonMap.containsKey('idimg')) idimg = jsonMap['idimg'] ?? '';
    if (jsonMap.containsKey('cnhNumero')) cnhNumero = jsonMap['cnhNumero'] ?? '';
    if (jsonMap.containsKey('cnhOrgaoEmissor')) cnhOrgaoEmissor = jsonMap['cnhOrgaoEmissor'] ?? '';
    if (jsonMap.containsKey('cnhCategoria')) cnhCategoria = jsonMap['cnhCategoria'] ?? '';
    if (jsonMap.containsKey('cnhImg')) cnhImg = jsonMap['cnhImg'] ?? '';
    if (jsonMap.containsKey('email1')) email1 = jsonMap['email1'] ?? '';
    if (jsonMap.containsKey('email2')) email2 = jsonMap['email2'] ?? '';
    if (jsonMap.containsKey('foto')) foto = jsonMap['foto'] ?? '';
    if (jsonMap.containsKey('cncNumero')) cncNumero = jsonMap['cncNumero'] ?? '';
    if (jsonMap.containsKey('tipoAutorizacaoPermissionario')) tipoAutorizacaoPermissionario = jsonMap['tipoAutorizacaoPermissionario'] ?? '';
    if (jsonMap.containsKey('cncImg')) cncImg = jsonMap['cncImg'] ?? '';
    if (jsonMap.containsKey('linkedIn')) linkedIn = jsonMap['linkedIn'] ?? '';
    if (jsonMap.containsKey('instagram')) instagram = jsonMap['instagram'] ?? '';
    if (jsonMap.containsKey('facebook')) facebook = jsonMap['facebook'] ?? '';
    if (jsonMap.containsKey('youtube')) youtube = jsonMap['youtube'] ?? '';
    if (jsonMap.containsKey('fiscal')) fiscal = jsonMap['fiscal'] ?? false;
    if (jsonMap.containsKey('podeFiscal')) podeFiscal = jsonMap['podeFiscal'] ?? false;
    if (jsonMap.containsKey('senha')) senha = jsonMap['senha'] ?? '';
    if (jsonMap.containsKey('status')) status = jsonMap['status'] ?? false;
    if (jsonMap.containsKey('plataforma')) plataforma = jsonMap['plataforma'] ?? '';
    if (jsonMap.containsKey('onLine')) onLine = jsonMap['onLine'] ?? false;
    if (jsonMap.containsKey('cidade')) cidade = jsonMap['cidade'] ?? '';
    if (jsonMap.containsKey('cidadeId')) cidadeId = jsonMap['cidadeId'] ?? 0;
    if (jsonMap.containsKey('veiculoId')) veiculoId = jsonMap['veiculoId'] ?? 0;
    if (jsonMap.containsKey('pontoEstacionamentoId')) pontoEstacionamentoId = jsonMap['pontoEstacionamentoId'] ?? 0;
    if (jsonMap.containsKey('codigoBanco')) codigoBanco = jsonMap['codigoBanco'] ?? '';
    if (jsonMap.containsKey('agencia')) agencia = jsonMap['agencia'] ?? '';
    if (jsonMap.containsKey('numeroConta')) numeroConta = jsonMap['numeroConta'] ?? '';
    if (jsonMap.containsKey('cnpjCpf')) cnpjCpf = jsonMap['cnpjCpf'] ?? '';
    if (jsonMap.containsKey('emailValidado')) emailValidado = jsonMap['emailValidado'] ?? false;
    if (jsonMap.containsKey('versionApp')) versionApp = jsonMap['versionApp'] ?? '';
    if (jsonMap.containsKey('assinatura')) assinatura = jsonMap['assinatura'] ?? '';
    if (jsonMap.containsKey('credito')) credito = jsonMap['credito'] ?? '';
    if (jsonMap.containsKey('whatsapp')) whatsapp = jsonMap['whatsapp'] ?? '';
    if (jsonMap.containsKey('pmImg')) pmImg = jsonMap['pmImg'] ?? '';
    if (jsonMap.containsKey('sexo')) sexo = jsonMap['sexo'] ?? 0;
    if (jsonMap.containsKey('idiomaLibra')) idiomaLibra = jsonMap['idiomaLibra'] ?? false;
    if (jsonMap.containsKey('aptoCego')) aptoCego = jsonMap['aptoCego'] ?? false;
    if (jsonMap.containsKey('biometriaValidada')) biometriaValidada = jsonMap['biometriaValidada'] ?? false;
    if (jsonMap.containsKey('manterConectado')) manterConectado = jsonMap['manterConectado'] ?? false;
    if (jsonMap.containsKey('pedirPontoEstacionamento')) pedirPontoEstacionamento = jsonMap['pedirPontoEstacionamento'] ?? false;
    if (jsonMap.containsKey('exigirBiometria')) exigirBiometria = jsonMap['exigirBiometria'] ?? false;
    if (jsonMap.containsKey('idDtEmissao')) idDtEmissao = BaseModelo.convertToDate(jsonMap['idDtEmissao']);
    if (jsonMap.containsKey('cnhDtemissao')) cnhDtemissao = BaseModelo.convertToDate(jsonMap['cnhDtemissao']);
    if (jsonMap.containsKey('cnhDtValidade')) cnhDtValidade = BaseModelo.convertToDate(jsonMap['cnhDtValidade']);
    if (jsonMap.containsKey('cnhDtUltimaAtualizacao')) cnhDtUltimaAtualizacao = BaseModelo.convertToDate(jsonMap['cnhDtUltimaAtualizacao']);
    if (jsonMap.containsKey('fotoDtCadastro')) fotoDtCadastro = BaseModelo.convertToDate(jsonMap['fotoDtCadastro']);
    if (jsonMap.containsKey('cncDtemissao')) cncDtemissao = BaseModelo.convertToDate(jsonMap['cncDtemissao']);
    if (jsonMap.containsKey('dtAdesao')) dtAdesao = BaseModelo.convertToDate(jsonMap['dtAdesao']);
    if (jsonMap.containsKey('dtBiometria')) dtBiometria = BaseModelo.convertToDate(jsonMap['dtBiometria']);
    if (jsonMap.containsKey('ultimaComunicacaoBackOffice')) ultimaComunicacaoBackOffice = BaseModelo.convertToDate(jsonMap['ultimaComunicacaoBackOffice']);
    if (jsonMap.containsKey('dtValidacaoEmail')) dtValidacaoEmail = BaseModelo.convertToDate(jsonMap['dtValidacaoEmail']);
    if (jsonMap.containsKey('dtHabilitacao')) dtHabilitacao = BaseModelo.convertToDate(jsonMap['dtHabilitacao']);
    if (jsonMap.containsKey('dtOnLine')) dtOnLine = BaseModelo.convertToDate(jsonMap['dtOnLine']);
    if (jsonMap.containsKey('dtNascto')) dtNascto = BaseModelo.convertToDate(jsonMap['dtNascto']);
  }

  @override
  void getLocal() {
    // TODO: implement getLocal
  }

  @override
  void getRemote() {
    // TODO: implement getRemote
  }

  @override
  void setLocal() {
    // TODO: implement setLocal
  }

  @override
  Future<bool> setRemoto() {
    // TODO: implement setRemoto
    throw UnimplementedError();
  }
}
