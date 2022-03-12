import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../DataHandler/appData.dart';
import '../../componentes/divider_widget.dart';
import '../search/searchScreen.dart';

class CustonPositionCancelRequest extends StatefulWidget {
  const CustonPositionCancelRequest({Key? key,required this.seacherContainerHeight, required this.displayRiderDetailContainer}) : super(key: key);

  final double seacherContainerHeight;
  final Function displayRiderDetailContainer;

  @override
  _CustonPositionCancelRequestState createState() => _CustonPositionCancelRequestState(seacherContainerHeight: seacherContainerHeight,
      displayRiderDetailContainer: displayRiderDetailContainer);
}

class _CustonPositionCancelRequestState extends State<CustonPositionCancelRequest> {

  double seacherContainerHeight = 0;
  late Function displayRiderDetailContainer;

  _CustonPositionCancelRequestState({required this.seacherContainerHeight, required this.displayRiderDetailContainer });

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
          height: seacherContainerHeight,
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
            padding: const EdgeInsets.symmetric(
                horizontal: 24.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "Olá, ",
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  "Para onde vamos?",
                  style: TextStyle(
                      fontSize: 20.0, fontFamily: "Brand Bold"),
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
                      displayRiderDetailContainer();
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
                          Text("Buscar endereço"),
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
                              Provider.of<AppData>(context)
                                  .pickUpLocation != null
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
                          style: TextStyle(
                              color: Colors.blue, fontSize: 12.0),
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
                          style: TextStyle(
                              color: Colors.blue, fontSize: 12.0),
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
