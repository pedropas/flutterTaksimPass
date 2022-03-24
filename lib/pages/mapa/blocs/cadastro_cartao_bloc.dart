import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taksim/dominio/ent_cartao_passageiro.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import 'package:taksim/helpers/enums_controler.dart';

class AdicionarCartaoBloc extends BlocBase {
  final _CartaoNovoController = BehaviorSubject<String>();
  final _NomeCartaoController = BehaviorSubject<String>();
  final _DataCartaoController = BehaviorSubject<String>();
  final _CVVCartaoController = BehaviorSubject<String>();
  final _DocumentoCartaoController = BehaviorSubject<String>();
  final _TipoCartaoController = BehaviorSubject<int>();
  final _FavoritoCartaoController = BehaviorSubject<bool>();
  final _FormSubmitController = BehaviorSubject<bool>();
  final _ScreenStateController = BehaviorSubject<stateScreenEnum>();

  EntPassageiro passageiro = EntPassageiro();

  Stream<String> get cartaoNovo => _CartaoNovoController.stream;
  Stream<String> get nomeCartao => _NomeCartaoController.stream;
  Stream<String> get dataCartao => _DataCartaoController.stream;
  Stream<String> get CVVCartao => _CVVCartaoController.stream;
  Stream<String> get documentoCartao => _DocumentoCartaoController;
  Stream<int> get tipoCartao => _TipoCartaoController.stream;
  Stream<bool> get favoritoCartao => _FavoritoCartaoController.stream;
  Stream<bool> get submittForm => _FormSubmitController.stream;
  Stream<stateScreenEnum> get stateScreenAtual => _ScreenStateController.stream;

  bool isFavorito = false;

  AdicionarCartaoBloc() {
    passageiro.getLocal();
    _ScreenStateController.add(stateScreenEnum.SCREEN_IDLE);
  }

  void setNumeroCartao(String value) {
    _CartaoNovoController.sink.add(value);
    isTodosCamposDigitado();
  }

  void setNomeCartao(String value) {
    _NomeCartaoController.sink.add(value);
    isTodosCamposDigitado();
  }

  void setDataCartao(String value) {
    _DataCartaoController.sink.add(value);
    isTodosCamposDigitado();
  }

  void setCVVCartao(String value) {
    _CVVCartaoController.sink.add(value);
    isTodosCamposDigitado();
  }

  void setTipoCartao(int value) {
    _TipoCartaoController.sink.add(value);
    isTodosCamposDigitado();
  }

  void setDocumentoCartao(String value) {
    _DocumentoCartaoController.sink.add(value);
    isTodosCamposDigitado();
  }

  void setFavoritoCartao() {
    isFavorito = !isFavorito;
    _FavoritoCartaoController.sink.add(isFavorito);
  }

  void isTodosCamposDigitado() {
    bool result = _CartaoNovoController.hasValue &&
        _NomeCartaoController.hasValue &&
        _DataCartaoController.hasValue &&
        _CVVCartaoController.hasValue &&
        _DocumentoCartaoController.hasValue;
    if (result)
      _ScreenStateController.add(stateScreenEnum.SCREEN_INSERT);
    else
      _ScreenStateController.add(stateScreenEnum.SCREEN_IDLE);
  }

  void setFinalizarCadastro() {
      _ScreenStateController.add(stateScreenEnum.SCREEN_LOADING);
      String cartaoNovo = _CartaoNovoController.value;
      String nomeCartao = _NomeCartaoController.value;
      String dataValidade = _DataCartaoController.value;
      String cvvCartao = _CVVCartaoController.value;
      int tipoCreditoDebito = _TipoCartaoController.value;
      bool favoritoCartao = true;
      try {
        favoritoCartao = _FavoritoCartaoController.value;
      }
      catch (e){
        favoritoCartao = true;
      }

      EntCartaoPassageiro cartaoPassageiro = EntCartaoPassageiro(
        passageiroId: passageiro.id,
        quatroUltimosCartao: cartaoNovo,
        origem: '00',
        token: '00',
        validade: dataValidade,
        status: false,
        brand: 'OUTROS',
        adquirenteId: 0,
      );
      cartaoPassageiro.status = favoritoCartao;
      cartaoPassageiro.nomeCartao = nomeCartao;
      cartaoPassageiro.tipoCartao = tipoCreditoDebito;
      cartaoPassageiro.CVV = cvvCartao;
      cartaoPassageiro.setRemoto().then((value) {
        if (value)
          _ScreenStateController.add(stateScreenEnum.SCREEN_SUCCESS);
        else
          _ScreenStateController.add(stateScreenEnum.SCREEN_FAIL);
      });
  }

  @override
  void dispose() {
    _CartaoNovoController.close();
    _NomeCartaoController.close();
    _DataCartaoController.close();
    _CVVCartaoController.close();
    _TipoCartaoController.close();
    _FavoritoCartaoController.close();
    _DocumentoCartaoController.close();
  }
}
