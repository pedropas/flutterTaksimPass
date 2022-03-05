import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:taksim/pages/base/page_store.dart';
import 'package:taksim/pages/login/login_screen.dart';
import 'package:taksim/pages/splash/splash3.dart';

import '../apresentacao/on_board.dart';
import '../cadastro/idioma/escolha_Idioma.dart';
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
        ],
      ),
    );
  }
}
