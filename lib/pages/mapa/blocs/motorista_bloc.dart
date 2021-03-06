import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taksim/dominio/EntDataModel1.dart';
import 'package:taksim/dominio/badget_custom.dart';
import 'package:taksim/dominio/ent_motorista.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import '../../../DataHandler/appData.dart';
import '../../../assistants/assistantMethods.dart';
import '../../../dominio/directDetails.dart';
import '../../../helpers/enums_controler.dart';

class MotoristaBloc extends BlocBase {
  final _MotoristaController = BehaviorSubject<List>();
  final _ScreenStateController = BehaviorSubject<stateScreenEnum>();
  final _TripDirectionDetailsController = BehaviorSubject<DirectionDetails>();

  final _PolylineSetController = BehaviorSubject<Set<Polyline>>();
  final _MarkersSetController = BehaviorSubject<Set<Marker>>();
  final _CirclesSetController = BehaviorSubject<Set<Circle>>();
  final _DataModel1Controller = BehaviorSubject<EntDataModel1>();
  final _TempoViagemController = BehaviorSubject<String>();
  final _BadgetController = BehaviorSubject<BadgetCustom>();


  EntMotorista motorista = EntMotorista();
  int motoristaId = 0;
  bool cancelarTimer = false;
  EntPassageiro passageiro = EntPassageiro();
  LatLng pickUpLatLng = LatLng(0, 0);
  LatLng dropOffLatLng = LatLng(0, 0);
  String ultimaPosicao = "";
  int ultimaTarifa = 1;

  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  Stream<List> get outMotoristas => _MotoristaController.stream;

  Stream<stateScreenEnum> get outStateScreen => _ScreenStateController.stream;

  Stream<DirectionDetails> get outTripDirectionalDetail =>
      _TripDirectionDetailsController.stream;

  Stream<Set<Polyline>> get outPolylineSet => _PolylineSetController.stream;

  Stream<Set<Marker>> get outMarkerSet => _MarkersSetController.stream;

  Stream<Set<Circle>> get outCirleSet => _CirclesSetController.stream;

  Stream<EntDataModel1> get outDataModel1 => _DataModel1Controller.stream;

  Stream<String> get outTempoViagem => _TempoViagemController.stream;
  Stream<BadgetCustom> get outBadgetPosicao => _BadgetController.stream;


  MotoristaBloc() {
    passageiro.getLocal();
  }

  void pedeConfirmacaoMotorista(
      {required String enderecoOrigem,
      required int motoristaId,
      required BuildContext context}) {
    motorista.id = motoristaId;
    _ScreenStateController.add(stateScreenEnum.SCREEN_LOADING);

    motorista
        .pedidoCorrida(passageiro.id, passageiro.senha, enderecoOrigem,
            passageiro.percentualDesconto)
        .then((value) {
      if (value) {
        _ScreenStateController.add(stateScreenEnum.SCREEN_SUCCESS);
        esperandoRespostaMotorista(context);
      } else {
        print(motorista.getRetorno());
        if (motorista.getRetorno() ==
            'Exception: Motorista indispon??vel neste momento!') {
          _ScreenStateController.add(stateScreenEnum.SCREEN_FAIL);
          cancelarTimer = true;
        } else if (motorista.getRetorno() ==
            'Exception: Motorista esta a caminho!') {
          _ScreenStateController.add(
              stateScreenEnum.SCREEN_MOTORISTA_A_CAMINHO);
          cancelarTimer = true;
        } else
          esperandoRespostaMotorista(context);
      }
    });
  }

  Future<void> esperandoRespostaMotorista(BuildContext context) async {
    cancelarTimer = false;
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (cancelarTimer)
        t.cancel();
      else
        verificaRespostaMotorista(context);
    });
  }

  String getRetorno() {
    return motorista.msgErro.replaceAll("Exception: ", "");
  }

  Future<void> verificaRespostaMotorista(BuildContext context) async {
    AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData != null) {
      if (passageiro.latitude != appData.pickUpLocation.latitude ||
          passageiro.longitude != appData.pickUpLocation.longitude) {
        passageiro.latitude = appData.pickUpLocation.latitude;
        passageiro.longitude = appData.pickUpLocation.longitude;
        if (passageiro.id != 0) passageiro.setLocal();
      }
    }
    motorista
        .buscarRepostaPedido(passageiro.id, passageiro.senha)
        .then((value) {
      if (value) {
        cancelarTimer = true;
        _ScreenStateController.add(
            stateScreenEnum.SCREEN_MOTORISTA_ACEITOU_VIAGEM);
        Future.delayed(Duration(seconds: 6), () {
          motoristaAceitouCorrida(context);
        });
      } else {
        if (motorista.msgErro == 'Exception: Motorista recusou a corrida') {
          _ScreenStateController.add(
              stateScreenEnum.SCREEN_MOTORISTA_RECUSOU_VIAGEM);
          cancelarTimer = true;
        } else
          print(motorista.msgErro);
      }
    });
  }

  Future<void> motoristaAceitouCorrida(BuildContext context) async {
    cancelarTimer = false;
    Timer.periodic(Duration(seconds: 3), (Timer t) {
      if (cancelarTimer)
        t.cancel();
      else
        verificaPosicaoMotorista(context);
    });
  }

  Future<void> verificaPosicaoMotorista(BuildContext context) async {
    AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData != null) {
      if (passageiro.latitude != appData.pickUpLocation.latitude ||
          passageiro.longitude != appData.pickUpLocation.longitude) {
        passageiro.latitude = appData.pickUpLocation.latitude;
        passageiro.longitude = appData.pickUpLocation.longitude;
        if (passageiro.id != 0) passageiro.setLocal();
      }
      pickUpLatLng = LatLng(passageiro.latitude, passageiro.longitude);
    }
    motorista.buscarPosicaoAtual(passageiro.id, passageiro.senha).then((value) {
      if (value) {
        if (motorista.getRetorno() != null) {
          EntDataModel1 dataModel1 =
              EntDataModel1.fromJson(json.decode(motorista.getRetorno()));
          dropOffLatLng = LatLng(dataModel1.latitude, dataModel1.longitude);
          getPlaceDirectionDriverToPassengerBloc();
          if (dataModel1.action ==
              actionPassageiro.ACTION_EM_CORRIDA_MACANETA.index)
          {
            if (_ScreenStateController.valueOrNull !=
                stateScreenEnum.SCREEN_EM_PAGAMENTO) {
              _ScreenStateController.add(stateScreenEnum.SCREEN_EM_PAGAMENTO);
            }
          }
          else if (dataModel1.action ==
              actionPassageiro.ACTION_EM_CORRIDA_MACANETA.index) {
            if (_ScreenStateController.valueOrNull !=
                stateScreenEnum.SCREEN_EM_CORRIDA) {
              _ScreenStateController.add(stateScreenEnum.SCREEN_EM_CORRIDA);
            }

            {
              _DataModel1Controller.add(dataModel1);
              int minutes = (dataModel1.tempoTaximetro / 60).toInt();
              int seconds = (dataModel1.tempoTaximetro % 60);
              String tempoTaximetro = minutes.toString().padLeft(2, "0") +
                  ":" +
                  seconds.toString().padLeft(2, "0");
              _TempoViagemController.add(tempoTaximetro);

              Color cFundo=Colors.green;
              Color cFont=Colors.white;
              String texto = dataModel1.posicao;
              if (dataModel1.posicao == 'L') {
                cFundo = Colors.green;
                cFont = Colors.white;
              } else if (dataModel1.posicao == 'C') {
                cFundo = Colors.blue;
                cFont = Colors.white;
                if (dataModel1.tarifa == 1)
                  texto = '1';
                else if (dataModel1.tarifa == 2)
                  texto = '2';
              }
              else if (dataModel1.posicao == 'P') {
                cFundo = Colors.red;
                cFont = Colors.white;
              } else if (dataModel1.posicao == 'S') {
                cFundo = Colors.yellow;
                cFont = Colors.black;
              } else if (dataModel1.posicao == 'D') {
                cFundo = Colors.black;
                cFont = Colors.white;
              }
              if ((ultimaPosicao != dataModel1.posicao)
                || (dataModel1.tarifa != ultimaTarifa)) {
                _BadgetController.add(BadgetCustom(color: cFundo
                    , textColor: cFont
                    , text: texto));
                ultimaPosicao = dataModel1.posicao;
                ultimaTarifa = dataModel1.tarifa;
              }
            }
          }
        }
      } else {}
    });
  }

  void cancelarCorrida() {
    print("Cancelar pedido");
  }

  @override
  void dispose() {
    _MotoristaController.close();
  }

  Future<void> getPlaceDirectionDriverToPassengerBloc() async {
    List<LatLng> pLineCoordinates = [];

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);

    if (details == null) {
      // n??o conseguiu tra??ar rota
      return;
    }

    _TripDirectionDetailsController.add(details);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();

    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    Polyline polyline = Polyline(
      color: Colors.blue,
      polylineId: PolylineId("PolylineID"),
      jointType: JointType.round,
      points: pLineCoordinates,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );

    polylineSet.add(polyline);
    _PolylineSetController.add(polylineSet);

    LatLngBounds latLngBounds;
    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    // newGoogleMapController
    //     .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: "", snippet: "Ponto partida"),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpId"),
    );
    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: "", snippet: "Meu destino"),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffId"),
    );

    markersSet.add(pickUpLocMarker);
    markersSet.add(dropOffLocMarker);
    _MarkersSetController.add(markersSet);

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: const CircleId("pickUpId"),
    );
    Circle dropOffLocCircle = Circle(
      fillColor: Colors.deepPurple,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepPurple,
      circleId: const CircleId("dropOffId"),
    );
    circlesSet.add(pickUpLocCircle);
    circlesSet.add(dropOffLocCircle);
    _CirclesSetController.add(circlesSet);
  }
}
