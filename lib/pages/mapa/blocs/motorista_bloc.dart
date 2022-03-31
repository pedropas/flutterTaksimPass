import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taksim/dominio/EntDataModel1.dart';
import 'package:taksim/dominio/ent_motorista.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import '../../../DataHandler/appData.dart';
import '../../../helpers/enums_controler.dart';

class MotoristaBloc extends BlocBase {
  final _MotoristaController = BehaviorSubject<List>();
  final _ScreenStateController = BehaviorSubject<stateScreenEnum>();

  EntMotorista motorista = EntMotorista();
  int motoristaId = 0;
  bool cancelarTimer = false;
  EntPassageiro passageiro = EntPassageiro();

  Stream<List> get outMotoristas => _MotoristaController.stream;
  Stream<stateScreenEnum> get outStateScreen => _ScreenStateController.stream;

  MotoristaBloc() {
    passageiro.getLocal();
  }

  void pedeConfirmacaoMotorista(
      {required String enderecoOrigem, required int motoristaId, required BuildContext context}) {
    motorista.id = motoristaId;
    _ScreenStateController.add(stateScreenEnum.SCREEN_LOADING);

    motorista
        .pedidoCorrida(passageiro.id, passageiro.senha, enderecoOrigem, passageiro.percentualDesconto)
        .then((value) {
      if (value) {
        _ScreenStateController.add(stateScreenEnum.SCREEN_SUCCESS);
        esperandoRespostaMotorista(context);
      } else {
        print(motorista.getRetorno());
        if (motorista.getRetorno() ==
            'Exception: Motorista indisponível neste momento!') {
          _ScreenStateController.add(stateScreenEnum.SCREEN_FAIL);
          cancelarTimer = true;
        }
        else if (motorista.getRetorno() ==
            'Exception: Motorista esta a caminho!') {
          _ScreenStateController.add(stateScreenEnum.SCREEN_MOTORISTA_A_CAMINHO);
          cancelarTimer = true;
        }
        else
          esperandoRespostaMotorista(context);
      }
    });
  }

  Future<void> esperandoRespostaMotorista(BuildContext context) async {
    cancelarTimer = false;
    Timer.periodic(Duration(seconds: 10), (Timer t) {
      if (cancelarTimer)
        t.cancel();
      else
        verificaRespostaMotorista(context);
    });
  }

  String getRetorno() {
    return motorista.msgErro.replaceAll("Exception: ", "");
  }

  void verificaRespostaMotorista(BuildContext context) async {
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
          if (passageiro.id != 0)
            passageiro.setLocal();
        }
      }
      motorista.buscarRepostaPedido(passageiro.id,passageiro.senha).then((value) {
        if (value){
           cancelarTimer = true;
           _ScreenStateController.add(stateScreenEnum.SCREEN_MOTORISTA_ACEITOU_VIAGEM);
        }
        else {
          if (motorista.msgErro == 'Exception: Motorista recusou a corrida') {
            _ScreenStateController.add(stateScreenEnum.SCREEN_MOTORISTA_RECUSOU_VIAGEM);
            cancelarTimer = true;
          }
          else
            print(motorista.msgErro);
        }
      });
  }

  void cancelarCorrida() {
    print("Cancelar pedido");
  }

  @override
  void dispose() {
    _MotoristaController.close();
  }
}
