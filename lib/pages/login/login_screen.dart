import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:taksim/helpers/network_const.dart';
import 'package:taksim/pages/login/model_login.dart';
import 'package:taksim/pages/login/repository_login.dart';

import '../../componentes/custom_icon_button.dart';
import '../../componentes/error_box.dart';
import 'login_store.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userSenhaController = TextEditingController();
  final RepositoryLogin passageiroRepository = RepositoryLogin(endPointLogint: END_POINT_LOGIN_PASSAGEIRO);
  final ModelLogin passageiroModel = ModelLogin();

  LoginStore loginStore = LoginStore(isAppleLogin: false
      , isGoogleLogin: false);

  //
  @override
  void initState()
  {
    super.initState();
    passageiroRepository.loadLocal().then((value) {
      setState(() {
        if (value.usuario.isNotEmpty) {
          loginStore.email = value.usuario;
          userEmailController.text = value.usuario;
        }
        if (value.senha.isNotEmpty) {
          loginStore.password = value.senha;
          userSenhaController.text = value.senha;
        }
        if (value.manterConectado && value.usuario.isNotEmpty && value.senha.isNotEmpty)
        {
          //  loginStore.setLoginUser();
        }
      });
    });
    when((_) => loginStore.isLogado,(){
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 9,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Acessar com E-mail:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                    child: Text(
                      'E-mail',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Observer(builder:(_){
                  return TextField(
                    enabled: !loginStore.loading,
                    controller: userEmailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      isDense: true,
                      errorText: loginStore.emailError,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: loginStore.setEmail,
                  );}),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Senha:',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          child: const Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.purple,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Observer(builder:(_) {
                    return TextField(
                      enabled: !loginStore.loading,
                      controller: userSenhaController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        errorText: loginStore.passwordError,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: loginStore.passwordVisible ? Icons.visibility: Icons.visibility_off,
                          onTap: loginStore.togglePasswordVisibility,
                        ),
                      ),
                      obscureText: !loginStore.passwordVisible,
                      onChanged: loginStore.setPassword,
                    );
                  }),
                  const SizedBox(height: 16,),
                  Observer(builder:(_) {
                    return Container(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: (loginStore.isLoginButtonOk && !loginStore.loading) ?
                        loginStore.setLoginUser : null,
                        child: loginStore.loading ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text('ENTRAR'),
                      ),
                    );
                  }),
                  SizedBox(height: 10,),
                  Observer(builder: (_) {
                    return ErrorBox(
                      message: loginStore.errorMsg,
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
