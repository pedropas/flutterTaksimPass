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
import 'package:taksim/dominio/ent_motorista.dart';
import 'package:taksim/dominio/ent_passageiro.dart';
import '../../../DataHandler/appData.dart';
import '../../../assistants/assistantMethods.dart';
import '../../../dominio/directDetails.dart';
import '../../../helpers/enums_controler.dart';

class MotoristaBloc extends BlocBase {
  final _MotoristaController = BehaviorSubject<List>();
  final _ScreenStateController = BehaviorSubject<stateScreenEnum>();
  final _LatitudeMotoristaController = BehaviorSubject<double>();
  final _LongitudeMotoristaController = BehaviorSubject<double>();
  final _LatitudePassageiroController = BehaviorSubject<double>();
  final _LongitudePassageiroController = BehaviorSubject<double>();
  final _TripDirectionDetailsController = BehaviorSubject<DirectionDetails>();

  final  _NewGoogleMapController = BehaviorSubject<GoogleMapController>();
  final _PolylineSetController =  BehaviorSubject<Set<Polyline>>();
  final _MarkersSetController =  BehaviorSubject<Set<Marker>>();
  final _CirclesSetController =  BehaviorSubject<Set<Circle>>();

  EntMotorista motorista = EntMotorista();
  int motoristaId = 0;
  bool cancelarTimer = false;
  EntPassageiro passageiro = EntPassageiro();

  Stream<List> get outMotoristas => _MotoristaController.stream;
  Stream<stateScreenEnum> get outStateScreen => _ScreenStateController.stream;

  Stream<double> get outLatitudeMotorista => _LatitudeMotoristaController.stream;
  Stream<double> get outLongitudeMotorista => _LongitudeMotoristaController.stream;
  Stream<double> get outLatitudePassageiro => _LatitudePassageiroController.stream;
  Stream<double> get outLongitudePassageiro => _LongitudePassageiroController.stream;
  Stream<DirectionDetails> get outTripDirectionalDetail => _TripDirectionDetailsController.stream;
  Stream<Set<Polyline>> get outPolylineSet => _PolylineSetController.stream;
  Stream<Set<Marker>> get outMarkerSet => _MarkersSetController.stream;
  Stream<Set<Circle>> get outCirleSet => _CirclesSetController.stream;


  MotoristaBloc() {
    passageiro.getLocal();
  }

  void pedeConfirmacaoMotorista(
      {required String enderecoOrigem, required int motoristaId, required BuildContext context}) {
    motorista.id = motoristaId;
    _ScreenStateController.add(stateScreenEnum.SCREEN_LOADING);

    motorista
        .pedidoCorrida(passageiro.id, passageiro.senha, enderecoOrigem, passageiro.percentualDesconto)
        .then((value) {
      if (value) {
        _ScreenStateController.add(stateScreenEnum.SCREEN_SUCCESS);
        esperandoRespostaMotorista(context);
      } else {
        print(motorista.getRetorno());
        if (motorista.getRetorno() ==
            'Exception: Motorista indisponível neste momento!') {
          _ScreenStateController.add(stateScreenEnum.SCREEN_FAIL);
          cancelarTimer = true;
        }
        else if (motorista.getRetorno() ==
            'Exception: Motorista esta a caminho!') {
          _ScreenStateController.add(stateScreenEnum.SCREEN_MOTORISTA_A_CAMINHO);
          cancelarTimer = true;
        }
        else
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
        if (passageiro.latitude !=
            appData.pickUpLocation
                .latitude ||
            passageiro.longitude !=
                appData.pickUpLocation
                    .longitude) {
          passageiro.latitude = appData.pickUpLocation
              .latitude;
          passageiro.longitude = appData.pickUpLocation
              .longitude;
          if (passageiro.id != 0)
            passageiro.setLocal();
        }
      }
      motorista.buscarRepostaPedido(passageiro.id,passageiro.senha).then((value) {
        if (value){
           cancelarTimer = true;
           _ScreenStateController.add(stateScreenEnum.SCREEN_MOTORISTA_ACEITOU_VIAGEM);
           Future.delayed(Duration(seconds: 6), (){
             motoristaAceitouCorrida(context);
           });
        }
        else {
          if (motorista.msgErro == 'Exception: Motorista recusou a corrida') {
            _ScreenStateController.add(stateScreenEnum.SCREEN_MOTORISTA_RECUSOU_VIAGEM);
            cancelarTimer = true;
          }
          else
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
      if (passageiro.latitude !=
          appData.pickUpLocation
              .latitude ||
          passageiro.longitude !=
              appData.pickUpLocation
                  .longitude) {
        passageiro.latitude = appData.pickUpLocation
            .latitude;
        passageiro.longitude = appData.pickUpLocation
            .longitude;
        if (passageiro.id != 0)
          passageiro.setLocal();
      }
      _LatitudePassageiroController.add(passageiro.latitude);
      _LongitudePassageiroController.add(passageiro.longitude);
    }
    motorista.buscarPosicaoAtual(passageiro.id,passageiro.senha).then((value) {
      if (value){
        if (motorista.getRetorno() != null) {
          EntDataModel1 dataModel1 = EntDataModel1.fromJson(
              json.decode(motorista.getRetorno()));
          print(dataModel1);
          _LatitudeMotoristaController.add(dataModel1.latitude);
          _LongitudeMotoristaController.add(dataModel1.longitude);
        }
      }
      else {
      }
    });
  }

  void cancelarCorrida() {
    print("Cancelar pedido");
  }

  @override
  void dispose() {
    _MotoristaController.close();
  }

  Future<void> getPlaceDirectionDriverToPassenger({required LatLng pickUpLatLng, required LatLng dropOffLatLng, required GoogleMapController newGoogleMapController}) async {
    List<LatLng> pLineCoordinates = [];
    Set<Polyline> polylineSet = {};
    Set<Marker> markersSet = {};
    Set<Circle> circlesSet = {};

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);


    if (details == null) {
      // não conseguiu traçar rota
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

    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow:
      const InfoWindow(title: "", snippet: "Ponto partida"),
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
