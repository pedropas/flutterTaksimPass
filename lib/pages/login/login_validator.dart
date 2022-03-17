import 'dart:async';

import 'package:taksim/helpers/extensions.dart';

class LoginValidator
{
   final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if (email.isEmailValid())
          sink.add(email);
        else
          sink.addError("Insira um e-mail valido");
      }
   );

   final validatePassword = StreamTransformer<String, String>.fromHandlers(
       handleData: (senha, sink) {
         if (senha.length > 4)
           sink.add(senha);
         else
           sink.addError("Mínimo 4 digitos");
       }
   );
}
