import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taksim/dominio/ent_passageiro.dart';

import '../../../helpers/config-gerais.dart';

class FormaPagamentoBloc extends BlocBase {
  final _formaPagamentoController = BehaviorSubject<int>();
  late EntPassageiro passageiro = EntPassageiro();

  Stream<int> get formaPagamentoPreferencial => _formaPagamentoController.stream;

  void setFormaPagamentoIndice(int value)
  {
    _formaPagamentoController.sink.add(value);
    String key = FORMA_PAGAMENTO_ICONE.keys.elementAt(value);
    passageiro.preferenciaFormaPagamento = key;
    passageiro.setLocal();
    passageiro.setFormaPagamento();
  }

  FormaPagamentoBloc()
  {
    int indice = 0;
    int count = 0;
    passageiro.getLocal();
    FORMA_PAGAMENTO_ICONE.forEach((key, value) {
      if (key == passageiro.preferenciaFormaPagamento) {
        indice = count;
      }
      count ++;
    });
    _formaPagamentoController.sink.add(indice);
  }

  @override
  void dispose() {

    _formaPagamentoController.close();
  }
}
