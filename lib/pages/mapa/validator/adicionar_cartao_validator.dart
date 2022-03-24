import 'dart:async';

import 'package:taksim/helpers/extensions.dart';

class AdicionarValidator
{
   final validateCartao = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if (email.isEmailValid())
          sink.add(email);
        else
          sink.addError("Insira um e-mail valido");
      }
   );
}
