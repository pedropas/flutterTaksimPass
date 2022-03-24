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
        quatroUltimosCartao: '1230',
        brand: 'VISA',
        adquirenteId: 1,
        status: true,
        validade: '00/00',
        origem: '0000',
        token: '0000',
      ),
       ];
    _CartoesPassageiroController.add(listOf);
  }

  @override
  void dispose() {
    _CartoesPassageiroController.close();
  }
}
