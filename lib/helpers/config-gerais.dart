import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const Map<String,IconData> FORMA_PAGAMENTO_ICONE = {'Cartão de crédito':FontAwesomeIcons.creditCard,
                                      'Cartão de débito': FontAwesomeIcons.solidCreditCard,
                                      'PIX':FontAwesomeIcons.atom,
                                      'Dinheiro':FontAwesomeIcons.moneyCheck,
                                      'POS':FontAwesomeIcons.magnet,
                                      'Crédito Eletrônico':FontAwesomeIcons.simCard,
                                      'PayPal':FontAwesomeIcons.paypal,};

const Map<String,String> CARD_BRAND = {'VISA':'assets/images/visacard.png',
                                         'MASTER':'assets/images/mastercard.png',
                                         'ELO':'assets/images/elocard.png',
                                         'OUTROS':'assets/images/outrocard.png',};

