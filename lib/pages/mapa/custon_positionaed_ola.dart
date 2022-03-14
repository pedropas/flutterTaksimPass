import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taksim/helpers/config_screen.dart';
import '../../DataHandler/appData.dart';
import '../../componentes/custom_button_Icon.dart';
import '../../componentes/divider_widget.dart';
import '../search/searchScreen.dart';

class CustonPositionedOla extends StatefulWidget {
  const CustonPositionedOla(
      {Key? key,
      required this.displayOlalContainer,
      required this.nomePassageiro})
      : super(key: key);

  final Function displayOlalContainer;
  final String nomePassageiro;

  @override
  _CustonPositionedOlaState createState() => _CustonPositionedOlaState(
      displayOlalContainer: displayOlalContainer,
      nomePassageiro: nomePassageiro);
}

class _CustonPositionedOlaState extends State<CustonPositionedOla> {
  double olarContainerHeight = 350.0;
  final Function displayOlalContainer;
  final String nomePassageiro;

  _CustonPositionedOlaState(
      {required this.displayOlalContainer, required this.nomePassageiro});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: AnimatedSize(
        duration: Duration(milliseconds: 160),
        curve: Curves.bounceIn,
        child: Container(
          height: olarContainerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 16.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      CustomButtonIcon(
                        onTap: () {},
                        label: 'Convênio',
                        prefix: false,
                        suffix: true,
                        icon: FontAwesomeIcons.solidEdit,
                        enabled: true,
                        backgroundCor: Colors.blue,
                        elevacao: 2,
                        espaco: 30.0,
                        textoCor: Colors.white,
                        radius: 30,
                        fontSize: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      CustomButtonIcon(
                        onTap: () {},
                        label: 'QR Code',
                        prefix: false,
                        suffix: true,
                        icon: FontAwesomeIcons.qrcode,
                        enabled: true,
                        backgroundCor: BUTTON_COLOR,
                        elevacao: 2,
                        espaco: 30.0,
                        textoCor: Colors.white,
                        radius: 30,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CustomButtonIcon(
                  onTap: () {},
                  label: 'Só quero um taxi',
                  prefix: false,
                  suffix: true,
                  icon: FontAwesomeIcons.taxi,
                  enabled: true,
                  backgroundCor: Colors.teal,
                  elevacao: 2,
                  espaco: 145.0,
                  textoCor: Colors.white,
                  radius: 30,
                  fontSize: 20,
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: Container(
                    child: Text(
                      "Olá, $nomePassageiro",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () async {
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                    if (res == "obtainDirection") {
                      displayOlalContainer();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 6.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10.0),
                          Text("Para onde vamos?"),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Text(
                              Provider.of<AppData>(context).pickUpLocation !=
                                      null
                                  ? Provider.of<AppData>(context)
                                      .pickUpLocation
                                      .placeName
                                  : 'Seu Endereço',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          "Seu Endereço",
                          style: TextStyle(color: Colors.blue, fontSize: 12.0),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                DividerWidget(corLinha: Colors.grey),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.work,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Serviço:"),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          "Seu Serviço",
                          style: TextStyle(color: Colors.blue, fontSize: 12.0),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
