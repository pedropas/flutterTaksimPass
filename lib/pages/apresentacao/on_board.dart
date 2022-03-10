import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:taksim/componentes/apresentacao.dart';

import '../base/page_store.dart';

class onBoard extends StatelessWidget {
  final PageController pageController = PageController();
  double pageCount = 0;

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Splash3Widget - FRAME
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*.95,
          child: PageIndicatorContainer(
            child: PageView(
              controller: pageController,
              children: [
                Apresentacao(
                    titulo: 'Bem Vindo à TAKSIM ',
                    texto:
                    'No escritório ou em casa, para o parque ou academia, com segurança, tranquilidade e comodidade, peça um Taxi quando e onde quiser. TAKSIM, uma solução inovadora para a mobilidade das cidades inteligentes.',
                    imagemPath: 'assets/images/onboardin1.png',
                    proximaPagina: proximaPagina,
                    paginaFinal: paginaFinal,
                    pularFinal: true),
                Apresentacao(
                  titulo: 'Segurança',
                  texto:'Para a sua segurança, a TAKSIM adota ferramentas modernas para o controle de imagens e biometria, e todas as corridas são monitoradas em tempo real.',
                  imagemPath: 'assets/images/onboardin2.png',
                  proximaPagina: proximaPagina,
                  paginaFinal: paginaFinal,
                  pularFinal: true),
                Apresentacao(
                    titulo: 'Comodidade',
                    texto:'Soluções completas de meios de pagamentos para as corridas, além de otimizar a distribuição da frota de acordo com a demanda de passageiros e veículos por região. TAKSIM, apertem os cintos e tenham todos uma boa viagem',
                    imagemPath: 'assets/images/onboardin3.png',
                    proximaPagina: proximaPagina,
                    paginaFinal: paginaFinal,
                    pularFinal: false),
              ],
              reverse: false,
            ),
            align: IndicatorAlign.bottom,
            length: 3,
            indicatorSpace: 10.0,
            indicatorColor: Colors.black,
            indicatorSelectorColor: Colors.blue,
          ),
        ),
      ),
    );
  }

  proximaPagina()
  {
    pageCount = pageController.page ?? 0;
    if (pageCount == 2)
      pageCount = 0;
    else
      pageCount ++;

    int temp = pageCount.toInt();
    pageController.jumpToPage(temp);
  }

  paginaFinal()
  {
    GetIt.I<PageStore>().setPage(2);
  }
}
