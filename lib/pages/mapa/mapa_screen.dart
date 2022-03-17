import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:taksim/pages/mapa/cabecalho_mapa.dart';
import 'package:taksim/pages/mapa/custon_positionaed_bem_vindo.dart';
import '../../DataHandler/appData.dart';
import '../../assistants/assistantMethods.dart';
import '../../componentes/drawer/custom_drawer.dart';
import '../../componentes/progressDialog.dart';
import '../../dominio/directDetails.dart';
import '../../dominio/ent_frota.dart';
import '../../dominio/ent_passageiro.dart';
import 'custon_positionaed_cancel.dart';
import 'custon_positionaed_ola.dart';
import 'custon_positionaed_rider_detail.dart';

class mapScreen extends StatefulWidget {
  const mapScreen({Key? key}) : super(key: key);

  @override
  _mapScreenState createState() => _mapScreenState();
}

class _mapScreenState extends State<mapScreen> with TickerProviderStateMixin {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  late DirectionDetails tripDirectionDetails = DirectionDetails();

  late List<LatLng> pLineCoordinates = [];
  late Set<Polyline> polylineSet = {};

  late Set<Marker> markersSet = {};
  late Set<Circle> circlesSet = {};

  bool showRiderDetailContainer = false;
  bool showOlaContainer = false;
  bool showCancelContainer = false;
  bool showBemVindoContainer = true;
  bool showCabecalhoMapa = false;

  String enderecoOrigem = 'Não Informado';
  String enderecoDestino = 'Não Informado';

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 300.0;

  late EntPassageiro passageiro;

  List<EntFrota> listOfVeiculo = [
    EntFrota(
      nomeFrota: 'Frota',
      tempoEstimado: '10 min',
      distanciaEstimado: '15,00',
      placaModelo: 'ABC1A234',
      veiculoImagem: 'assets/images/taxi.png',
      latitude: 0,
      longitude: 0,
      motoristaId: 1,
      percentualDesconto: 0,
    ),
    EntFrota(
      nomeFrota: 'Frota 2',
      tempoEstimado: '12 min',
      distanciaEstimado: 'R 12,00',
      placaModelo: 'ABC1B124',
      veiculoImagem: 'assets/images/taxi.png',
      latitude: 0,
      longitude: 0,
      motoristaId: 1,
      percentualDesconto: 0,
    ),
    EntFrota(
      nomeFrota: 'Frota 3',
      tempoEstimado: '12 min',
      distanciaEstimado: 'R 12,00',
      placaModelo: 'ABC1B155',
      veiculoImagem: 'assets/images/taxi.png',
      latitude: 0,
      longitude: 0,
      motoristaId: 1,
      percentualDesconto: 0,
    ),
    EntFrota(
      nomeFrota: 'Frota 4',
      tempoEstimado: '12 min',
      distanciaEstimado: 'R 12,00',
      placaModelo: 'ABC1B155',
      veiculoImagem: 'assets/images/taxi.png',
      latitude: 0,
      longitude: 0,
      motoristaId: 1,
      percentualDesconto: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();

    passageiro = EntPassageiro();
    passageiro.getLocal();

    AssistantMethods.getCurrentOnlineUserInfo();
  }

  void displayRiderDetailContainer() async {
    await getPlaceDirection();
    setState(() {
      showBemVindoContainer = false;
      showOlaContainer = false;
      showCabecalhoMapa = true;
      showRiderDetailContainer = true;
      bottomPaddingOfMap = 500.0;
    });
  }

  void displayRequestRideContainer() {
    setState(() {
      bottomPaddingOfMap = 230.0;
    });
  }

  void displayDriverDetailsContainer() {
    setState(() {
      bottomPaddingOfMap = 295.0;
    });
  }

  void onSoQueroUmTaxiClicked() {
    setState(() {
      showBemVindoContainer = false;
      showOlaContainer = false;
      showCabecalhoMapa = true;
      showRiderDetailContainer = true;
      bottomPaddingOfMap = 500.0;
      enderecoOrigem = 'Não informado';
      enderecoDestino = 'Não informado';
    });
  }
  void displayBemVindoContainer() {
    setState(() {
      showRiderDetailContainer = false;
      showBemVindoContainer = false;
      showOlaContainer = true;
      showCabecalhoMapa = false;
    });
  }

  String state = "normal";

  void cancelRideRequest() {
    setState(() {
      state = "normal";
    });
  }

  resetApp() {
    setState(() {
      bottomPaddingOfMap = 300.0;

      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      pLineCoordinates.clear();

      // statusRide = "";
      // driverName = "";
      // driverphone = "";
      // carDetailsDriver = "";
      // rideStatus = "Driver is Coming";
      // driverDetailsContainerHeight = 0.0;
    });
  }

  void locatePosition() async {
// ---------------------------------------------------------
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
// ---------------------------------------------------------
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(-19.975854113974894, -43.935645187060565), zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Mapa'),
        //   centerTitle: true,
        //   backgroundColor: Colors.transparent,
        // ),
        drawer: CustomDrawer(
            nomeCompleto: passageiro.nome,
            eMail: passageiro.email,
            foto: passageiro.getImageFoto() ??
                Image.asset('assets/images/user_icon.png')),
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(
                bottom: bottomPaddingOfMap,
                top: 25,
              ),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              polylines: polylineSet,
              markers: markersSet,
              circles: circlesSet,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
                setState(() {
                  bottomPaddingOfMap = 345.0;
                });
                locatePosition();
              },
            ),
            Container(
              child: showCabecalhoMapa
                  ? CabecalhoMapa(
                      origem: enderecoOrigem,
                      destino: enderecoDestino,
                      onRetornoClicked: voltarTela,
                    )
                  : null,
            ),
            // Pronto vamos lá
            Container(
              child: showBemVindoContainer
                  ? CustonPositionBemVindo(
                      bemVindoContainerHeight: 350.0,
                      displayBemVindoContainer: displayBemVindoContainer,
                    )
                  : null,
            ),
            // para onde
            Container(
              child: showOlaContainer
                  ? CustonPositionedOla(
                      displayOlalContainer: displayRiderDetailContainer,
                      nomePassageiro: passageiro.nomeSocial,
                      onConvenioClicked: () {},
                      onQrCodeClicked: () {},
                      onSoQueroUmTaxiClicked: onSoQueroUmTaxiClicked,
                    )
                  : null,
            ),
            //rider detail
            Container(
              child: showRiderDetailContainer
                  ? CustonPositionedRiderDetail(
                      displayRequestRideContainer: displayRequestRideContainer,
                      listOfVeiculo: listOfVeiculo,
                    )
                  : null,
            ),
            // // cancel wait
            // Container(
            //   child: false
            //       ? CustonPositionCancelRequest(
            //           seacherContainerHeight: 270.0,
            //           displayRiderDetailContainer: displayRiderDetailContainer,
            //         )
            //       : null,
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    enderecoOrigem = initialPos.placeName;
    enderecoDestino = finalPos.placeName;

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "Por favor espere...",
            ));

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);

    if (details == null) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) => ProgressDialog(
                message: "Náo conseguimos traçar sua rota",
              ));
      Timer(Duration(seconds: 5), () {
        setState(() {
          Navigator.pop(context);
        });
      });

      return;
    }
    setState(() {
      tripDirectionDetails = details;
    });

    Navigator.pop(context);

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

    setState(() {
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
    });

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
          InfoWindow(title: initialPos.placeName, snippet: "Ponto partida"),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpId"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: finalPos.placeName, snippet: "Meu destino"),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffId"),
    );

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("pickUpId"),
    );

    Circle dropOffLocCircle = Circle(
      fillColor: Colors.deepPurple,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepPurple,
      circleId: CircleId("dropOffId"),
    );

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });
  }

  void voltarTela() {
    displayBemVindoContainer();
  }
}
/*
 var decoded = json.decode(jsonString);
 List<EntFrota> frotas = decoded['item'].map<EntFrota>(
 (map) { return EntFrota.fromJson(map)}
 ).toList()
  */
