import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taksim/dominio/ent_frota.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import '../../../DataHandler/appData.dart';
import '../../../helpers/config-gerais.dart';
import '../../../helpers/enums_controler.dart';

class FrotaBloc extends BlocBase {
  final _frotaController = BehaviorSubject<List>();
  final _percentualDescontoController = BehaviorSubject<double>();
  final _formaPagamentoController = BehaviorSubject<String>();
  final _iconFormaPagamentoController = BehaviorSubject<IconData>();
  final _StatusAppScreenController = BehaviorSubject<stateScreenEnum>();

  bool cancelaTimer = false;
  EntPassageiro passageiro = EntPassageiro();
  double percentual = 0;

  Stream<List> get outFrotas => _frotaController.stream;

  Stream<double> get outPercentualDesconto =>
      _percentualDescontoController.stream;

  Stream<String> get outFormaPagamento => _formaPagamentoController.stream;

  Stream<IconData> get outIconFormaPagamento =>
      _iconFormaPagamentoController.stream;

  Stream<String> get outPercentualDescontoStr =>
      _percentualDescontoController.stream.transform(
        StreamTransformer<double, String>.fromHandlers(
            handleData: (perc, sink) {
          var f = NumberFormat('0#');
          String percentual = f.format(perc) + "%";
          sink.add(percentual);
        }),
      );

  Map<String, Map<String, dynamic>> _frotas = {};

  FrotaBloc(BuildContext context) {
    _addCarroFrotaQuadrante(context);
    passageiro.getLocal();
    _percentualDescontoController.sink.add(passageiro.percentualDesconto);
    percentual = passageiro.percentualDesconto;
    _formaPagamentoController.sink.add(passageiro.preferenciaFormaPagamento);
    _iconFormaPagamentoController.sink.add(
        FORMA_PAGAMENTO_ICONE[passageiro.preferenciaFormaPagamento] ??
            FontAwesomeIcons.moneyCheckAlt);
  }

  void _addCarroFrotaQuadrante(BuildContext context) async {
    Timer.periodic(Duration(seconds: 10), (Timer t) {
      verificaAtualizacaoListaFrota(context);
      if (cancelaTimer)
        t.cancel();
    });
  }

  void verificaAtualizacaoListaFrota(BuildContext context) async {
    _frotas.clear();
    AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData != null) {
      if (passageiro.latitude !=
              appData.pickUpLocation
                  .latitude ||
          passageiro.longitude !=
              appData.pickUpLocation
                  .longitude) {
        passageiro.latitude = appData.pickUpLocation
            .latitude;
        passageiro.longitude = appData.pickUpLocation
            .longitude;
        passageiro.setLocal();
      }
    }
    List<EntFrota> listOfFrota = await EntFrota(
            nomeFrota: 'nomeFrota',
            veiculoImagem: 'veiculoImagem',
            placaModelo: 'placaModelo',
            tempoEstimado: 'tempoEstimado',
            distanciaEstimado: 'distanciaEstimado',
            longitude: 0,
            latitude: 0,
            percentualDesconto: 0,
            motoristaId: 0)
        .getList();

    _frotaController.add(listOfFrota);
  }

  void onIncrementaClicked() {
    percentual++;
    if (percentual > 40) percentual = 40;

    atualizaPercentual(percentual);
  }

  void onDecrementaClicked() {
    percentual--;
    if (percentual < 0) percentual = 0;

    atualizaPercentual(percentual);
  }

  void atualizaPercentual(double percentual) {
    _percentualDescontoController.sink.add(percentual);
    passageiro.percentualDesconto = percentual;
    passageiro.setLocal();
  }

  @override
  void dispose() {
    _frotaController.close();
    _percentualDescontoController.close();
    _iconFormaPagamentoController.close();
    _formaPagamentoController.close();
    cancelaTimer = true;
  }
}
