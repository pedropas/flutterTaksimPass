import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:taksim/pages/base/page_store.dart';
import 'package:taksim/pages/cadastro/captura/imagem_captura.dart';
import 'package:taksim/pages/cadastro/termouso/texto_politica_contestacao.dart';
import 'package:taksim/pages/cadastro/termouso/texto_termo_uso.dart';
import 'package:taksim/pages/login/login_screen.dart';
import 'package:taksim/pages/splash/splash3.dart';

import '../apresentacao/on_board.dart';
import '../cadastro/idioma/escolha_Idioma.dart';
import '../cadastro/passageiro/passageiro_documento.dart';
import '../cadastro/passageiro/passageiro_parte_1.dart';
import '../cadastro/passageiro/passageiro_parte_2.dart';
import '../cadastro/passageiro/passageiro_senha.dart';
import '../cadastro/passageiro/passageiro_valida_conta.dart';
import '../cadastro/termouso/termo_uso.dart';
import '../cadastro/termouso/texto_politica_uso.dart';
import '../prelogin/pre_login.dart';

class BaseScreen extends StatefulWidget {
  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  void initState() {
    super.initState();
    reaction((_) => pageStore.page,
        (page) => pageController.jumpToPage(page as int));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Splash3Widget(),
          onBoard(),
          PreLogin(),
          LoginScreen(),
          EscolhaIdioma(),
          TermoUso(),
          TextoTermoUso(),
          TextoPoliticaUso(),
          TextoPoliticaContestacao(),
          PassageiroCadastroParte1(),
          PassageiroCadastroParte2(),
          PassageiroValidaConta(),
          PassageiroCadastroDocumento(),
          PassageiroCadastroSenha(),
          CapturaImagem(),
        ],
      ),
    );
  }
}
