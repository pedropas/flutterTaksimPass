import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taksim/dominio/EntDataModel1.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import '../../../helpers/enums_controler.dart';

class MotoristaBloc extends BlocBase {
  final _MotoristaController = BehaviorSubject<List>();
  final _ScreenStateController = BehaviorSubject<stateScreenEnum>();

  final int motoristaId;
  EntPassageiro passageiro = EntPassageiro();
  Stream<List> get outMotoristas => _MotoristaController.stream;

  MotoristaBloc({required this.motoristaId}) {
    _ScreenStateController.add(stateScreenEnum.SCREEN_LOADING);
  }

  Future<void> pedeConfirmacaoMotorista() async {

  }

  @override
  void dispose() {
    _MotoristaController.close();
  }
}
