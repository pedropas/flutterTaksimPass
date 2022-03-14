import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../DataHandler/appData.dart';
import '../../assistants/assistantMethods.dart';
import '../../componentes/divider_widget.dart';
import '../../dominio/directDetails.dart';
import '../search/searchScreen.dart';

class CustonPositionedRiderDetail extends StatefulWidget {
  const CustonPositionedRiderDetail({Key? key, required this.displayRequestRideContainer}) : super(key: key);

  final Function displayRequestRideContainer;

  @override
  _CustonPositionedRiderDetailState createState() => _CustonPositionedRiderDetailState(displayRequestRideContainer: displayRequestRideContainer);
}

class _CustonPositionedRiderDetailState extends State<CustonPositionedRiderDetail> {

  double riderDetailContainerHeight = 270;
  late Function displayRequestRideContainer;
  late DirectionDetails tripDirectionDetails = DirectionDetails();

  _CustonPositionedRiderDetailState({required this.displayRequestRideContainer });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: AnimatedSize(
        duration: Duration(milliseconds: 160),
        curve: Curves.bounceIn,
        child: Container(
          height: riderDetailContainerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 16.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.blueGrey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/taxi.png",
                        height: 70.0,
                        width: 80,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 17.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Carro:",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Brand Bold",
                              ),
                            ),
                            Text(
                              (tripDirectionDetails != null)
                                  ? tripDirectionDetails.distanceText
                                  : '',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        (tripDirectionDetails != null)
                            ? 'R\$ ${AssistantMethods.calculateFares(tripDirectionDetails)}'
                            : '',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.moneyCheckAlt,
                      size: 18,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text('Dinheiro'),
                    SizedBox(
                      width: 6.0,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black54,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    displayRequestRideContainer();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Solicitar",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.taxi,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
