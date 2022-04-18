import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taksim/helpers/config_screen.dart';
import 'package:taksim/helpers/enums_controler.dart';
import '../../componentes/custom_icon_button.dart';
import '../../componentes/custom_text_field_bloc.dart';
import 'blocs/cadastro_cartao_bloc.dart';

class CustonPositionAdicionarCartao extends StatefulWidget {
  const CustonPositionAdicionarCartao({
    Key? key,
    required this.onCancelarFormaPagamentoOpcaoClicked,
  }) : super(key: key);

  final VoidCallback onCancelarFormaPagamentoOpcaoClicked;

  @override
  _CustonPositionAdicionarCartaoState createState() =>
      _CustonPositionAdicionarCartaoState(
        onCancelarEcolhaCartaoClicked: onCancelarFormaPagamentoOpcaoClicked,
      );
}

class _CustonPositionAdicionarCartaoState
    extends State<CustonPositionAdicionarCartao> {
  double adicionaCartoesContainerHeight = 500;
  VoidCallback onCancelarEcolhaCartaoClicked;

  AdicionarCartaoBloc adicionarCartaoBloc = AdicionarCartaoBloc();

  _CustonPositionAdicionarCartaoState({
    required this.onCancelarEcolhaCartaoClicked,
  });

  var buttonStyleOff = ElevatedButton.styleFrom(
    elevation: 0,
    primary: Colors.transparent,
    shadowColor: Colors.transparent,
    side: const BorderSide(
      width: 1,
      color: BUTTON_COLOR,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  var buttonStyleOn = ElevatedButton.styleFrom(
    elevation: 0,
    primary: Colors.deepPurple.shade200,
    shadowColor: Colors.transparent,
    side: const BorderSide(
      width: 1,
      color: BUTTON_COLOR,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<stateScreenEnum>(
        stream: adicionarCartaoBloc.stateScreenAtual,
        builder: (context, statusTela) {
          return Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: AnimatedSize(
              duration: Duration(milliseconds: 160),
              curve: Curves.bounceIn,
              child: Container(
                height: adicionaCartoesContainerHeight,
                decoration: const BoxDecoration(
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
                      horizontal: 24.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: onCancelarEcolhaCartaoClicked,
                              child: const Icon(
                                FontAwesomeIcons.arrowLeft,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Expanded(
                              child: Text(
                                'Adicionar cartão Crédito/Débito',
                                style: TextStyle(
                                  fontFamily: "Montserrat Bold",
                                  fontSize: 15,
                                  color: BUTTON_COLOR,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // numero cartão
                      CustomTextFieldBloc(
                          label: "Número do cartão",
                          hint: "0000.0000.0000.0000",
                          textInputType: TextInputType.number,
                          enabled: true,
                          onChanged: adicionarCartaoBloc.setNumeroCartao,
                          stream: adicionarCartaoBloc.cartaoNovo,
                          prefix: CustomIconButton(
                            onTap: () {},
                            iconData: FontAwesomeIcons.creditCard,
                            radius: 50,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      // Nome impresso no cartao
                      CustomTextFieldBloc(
                          label: "Nome impresso no cartão",
                          hint: "Nome impresso....",
                          textInputType: TextInputType.name,
                          enabled: true,
                          onChanged: adicionarCartaoBloc.setNomeCartao,
                          stream: adicionarCartaoBloc.nomeCartao,
                          prefix: CustomIconButton(
                            onTap: () {},
                            iconData: FontAwesomeIcons.user,
                            radius: 50,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      // documento cartao
                      CustomTextFieldBloc(
                          label: "Documento",
                          hint: "C.P.F. ....",
                          textInputType: TextInputType.number,
                          enabled: true,
                          onChanged: adicionarCartaoBloc.setDocumentoCartao,
                          stream: adicionarCartaoBloc.documentoCartao,
                          prefix: CustomIconButton(
                            onTap: () {},
                            iconData: FontAwesomeIcons.idCard,
                            radius: 50,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          // Data validade
                          SizedBox(
                            width: 150,
                            child: CustomTextFieldBloc(
                                label: "Validade",
                                hint: "MM/AA",
                                textInputType: TextInputType.number,
                                enabled: true,
                                onChanged: adicionarCartaoBloc.setDataCartao,
                                stream: adicionarCartaoBloc.dataCartao,
                                prefix: CustomIconButton(
                                  onTap: () {},
                                  iconData: FontAwesomeIcons.calendarTimes,
                                  radius: 50,
                                )),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          //CVV
                          SizedBox(
                            width: 150,
                            child: CustomTextFieldBloc(
                                label: "CVV",
                                hint: "123",
                                textInputType: TextInputType.number,
                                enabled: true,
                                onChanged: adicionarCartaoBloc.setCVVCartao,
                                stream: adicionarCartaoBloc.CVVCartao,
                                prefix: CustomIconButton(
                                  onTap: () {},
                                  iconData: FontAwesomeIcons.key,
                                  radius: 50,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Função do cartão"),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 100,
                            child: StreamBuilder<int>(
                                initialData: 0,
                                stream: adicionarCartaoBloc.tipoCartao,
                                builder: (context, snapshot) {
                                  bool isCredito = (snapshot.data == 0);
                                  return ElevatedButton(
                                    onPressed: () {
                                      adicionarCartaoBloc.setTipoCartao(0);
                                    },
                                    child: const Text(
                                      "Crédito",
                                      style: TextStyle(color: BUTTON_COLOR),
                                    ),
                                    style: isCredito
                                        ? buttonStyleOn
                                        : buttonStyleOff,
                                  );
                                }),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: 100,
                            child: StreamBuilder<int>(
                                // initialData: 0,
                                stream: adicionarCartaoBloc.tipoCartao,
                                builder: (context, snapshot) {
                                  bool isCredito = (snapshot.data == 1);
                                  return ElevatedButton(
                                    onPressed: () {
                                      adicionarCartaoBloc.setTipoCartao(1);
                                    },
                                    child: const Text(
                                      "Débito",
                                      style: TextStyle(color: BUTTON_COLOR),
                                    ),
                                    style: isCredito
                                        ? buttonStyleOn
                                        : buttonStyleOff,
                                  );
                                }),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                              width: 125,
                              child: StreamBuilder<bool>(
                                  initialData: true,
                                  stream: adicionarCartaoBloc.favoritoCartao,
                                  builder: (context, snapshot) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        adicionarCartaoBloc.setFavoritoCartao();
                                      },
                                      child: const Text(
                                        "Favorito",
                                        style:
                                            TextStyle(color: Colors.deepPurple),
                                      ),
                                      style: (snapshot.data ?? false)
                                          ? buttonStyleOn
                                          : buttonStyleOff,
                                    );
                                  })),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      StreamBuilder<int>(
                          stream: adicionarCartaoBloc.tipoCartao,
                          builder: (context, snapshot) {
                            String labelCartao = snapshot.data == 0
                                ? "Adicionar cartão Crédito"
                                : "Adicionar cartão Débito";
                            return SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: stateScreenEnum.SCREEN_INSERT !=
                                        statusTela.data
                                    ? null
                                    : adicionarCartaoBloc.setFinalizarCadastro,
                                child: Row(
                                  children: [
                                    Text(
                                      labelCartao,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    const SizedBox(
                                      width: 110,
                                    ),
                                    const Icon(
                                      FontAwesomeIcons.plus,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    adicionarCartaoBloc.dispose();
    super.dispose();
  }
}
