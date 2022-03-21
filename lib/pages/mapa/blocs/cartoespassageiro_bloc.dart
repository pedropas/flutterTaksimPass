import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taksim/dominio/ent_cartao_passageiro.dart';
import 'package:taksim/dominio/ent_passageiro.dart';

import '../../../helpers/config-gerais.dart';

class CartoesPassageiroBloc extends BlocBase {
  final _CartoesPassageiroController =
      BehaviorSubject<List<EntCartaoPassageiro>>();

  EntPassageiro passageiro = EntPassageiro();

  Stream<List<EntCartaoPassageiro>> get listOfCartaoPassageiro =>
      _CartoesPassageiroController.stream;

  CartoesPassageiroBloc() {
    passageiro.getLocal();

    List<EntCartaoPassageiro> listOf = [
      EntCartaoPassageiro(
        passageiroId: 1,
        quatroUltimosCartao: 1230,
        brand: 'VISA',
        adquirenteId: 1,
        status: true,
      ),
      EntCartaoPassageiro(
        passageiroId: 1,
        quatroUltimosCartao: 1234,
        brand: 'MASTER',
        adquirenteId: 1,
        status: false,
      ),
      EntCartaoPassageiro(
        passageiroId: 1,
        quatroUltimosCartao: 1235,
        brand: 'ELO',
        adquirenteId: 1,
        status: false,
      ),
    ];
    _CartoesPassageiroController.add(listOf);
  }

  @override
  void dispose() {
    _CartoesPassageiroController.close();
  }
}
