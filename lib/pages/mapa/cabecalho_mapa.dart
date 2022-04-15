import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taksim/componentes/custom_icon_button.dart';
import 'package:taksim/helpers/config_screen.dart';

class CabecalhoMapa extends StatelessWidget {
  const CabecalhoMapa(
      {required this.origem,
      required this.destino,
      required this.onRetornoClicked,
      Key? key})
      : super(key: key);

  final String origem;
  final String destino;
  final VoidCallback onRetornoClicked;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25,
      left: 15,
      right: 15,
      child: Container(
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 40,
              width: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: CustomIconButton(
                    radius: 10,
                    iconData: Icons.arrow_back,
                    cor: BUTTON_COLOR,
                    onTap: onRetornoClicked),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              height: 40,
              width: 280,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      origem,
                      style: const TextStyle(
                        fontFamily: "Montserrat Bold",
                        fontSize: 10,
                      ),
                    )),
                    const Text(
                      "> ",
                      style: TextStyle(
                          fontFamily: "Montserrat Bold", color: BUTTON_COLOR),
                    ),
                    Expanded(
                        child: Text(
                      destino,
                      style: const TextStyle(
                        fontFamily: "Montserrat Bold",
                        fontSize: 10,
                      ),
                    )),
                    const Icon(
                      Icons.edit_location_alt,
                      color: BUTTON_COLOR,
                      size: 26.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
