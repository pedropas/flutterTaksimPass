import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:taksim/pages/mapa/blocs/motorista_bloc.dart';
import 'package:taksim/pages/mapa/cabecalho_mapa.dart';
import 'package:taksim/pages/mapa/custon_positionaed_bem_vindo.dart';
import 'package:taksim/pages/mapa/custon_positionaed_em_corrida.dart';
import 'package:taksim/pages/mapa/custon_positionaed_list_card_modify.dart';
import '../../DataHandler/appData.dart';
import '../../assistants/assistantMethods.dart';
import '../../componentes/drawer/custom_drawer.dart';
import '../../componentes/progressDialog.dart';
import '../../dominio/directDetails.dart';
import '../../dominio/ent_passageiro.dart';
import '../../helpers/enums_controler.dart';
import 'custon_positionaed_Forma_pagamento.dart';
import 'custon_positionaed_Forma_pagamento_opcao.dart';
import 'custon_positionaed_adicionar_cartao.dart';
import 'custon_positionaed_em_pagamento.dart';
import 'custon_positionaed_esperando_confirmacao_motorista.dart';
import 'custon_positionaed_motorista_a_caminho.dart';
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

  MotoristaBloc motoristaBloc = MotoristaBloc();
  bool showRiderDetailContainer = false;
  bool showOlaContainer = false;
  bool showCancelContainer = false;
  bool showBemVindoContainer = true;
  bool showCabecalhoMapa = false;
  bool showFormaPagamento = false;
  bool showFormaPagamentoOpcao = false;
  bool showCartaoOrModify = false;
  bool showAdicionarCartao = false;
  bool showEsperaMotoristaConfirmacao = false;
  bool showMotoristaACaminho = false;
  bool showEmCorridaContainer = false;
  bool showEmPagamentoContainer = false;


  String enderecoOrigem = 'Não Informado';
  String enderecoDestino = 'Não Informado';
  int motoristaId = 0;

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 350.0;

  late EntPassageiro passageiro;
  String state = "normal";

  @override
  void initState() {
    super.initState();

    passageiro = EntPassageiro();
    passageiro.getLocal();

    AssistantMethods.getCurrentOnlineUserInfo();

    motoristaBloc.outStateScreen.listen((event) {
      //event = stateScreenEnum.SCREEN_EM_CORRIDA;
      switch (event) {
        case stateScreenEnum.SCREEN_MOTORISTA_A_CAMINHO:
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Solicitação de viagem"),
              content: Text(motoristaBloc.getRetorno()),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      motoristaBloc.cancelarCorrida();
                      Navigator.pop(context);
                      displayBemVindoContainer();
                    },
                    child: Text("Cancelar")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      motoristaBloc.esperandoRespostaMotorista(context);
                    },
                    child: Text("Ok")),
              ],
            ),
            barrierDismissible: false,
          );
          break;
        case stateScreenEnum.SCREEN_FAIL:
          print(motoristaBloc.getRetorno());
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Solicitação de viagem"),
              content: Text(motoristaBloc.getRetorno()),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      displayBemVindoContainer();
                    },
                    child: Text("Ok")),
              ],
            ),
            barrierDismissible: false,
          );
          break;
        case stateScreenEnum.SCREEN_MOTORISTA_RECUSOU_VIAGEM:
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Solicitação de viagem"),
              content: Text("Motorista esta indisponível no momento!"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      displayBemVindoContainer();
                    },
                    child: Text("Ok")),
              ],
            ),
            barrierDismissible: false,
          );
          break;
        case stateScreenEnum.SCREEN_MOTORISTA_ACEITOU_VIAGEM:
          displayMotoristaAceitouCorrida();
          // traçar rota entre motorista e passageiro
          break;
        case stateScreenEnum.SCREEN_EM_CORRIDA:
          displayEmCorrida();
          // traçar rota entre motorista e passageiro
          break;
        case stateScreenEnum.SCREEN_EM_PAGAMENTO:
          displayEmPagamento();
          break;
        case stateScreenEnum.SCREEN_SUCCESS:
        case stateScreenEnum.SCREEN_LOADING:
        case stateScreenEnum.SCREEN_INSERT:
        case stateScreenEnum.SCREEN_IDLE:
        case stateScreenEnum.SCREEN_ESPERANDO_CONFIRMACAO_MOTORISTA:
      }
    });
  }

  void fechaTudo() {
    showRiderDetailContainer = false;
    showOlaContainer = false;
    showCancelContainer = false;
    showBemVindoContainer = false;
    showCabecalhoMapa = false;
    showFormaPagamento = false;
    showFormaPagamentoOpcao = false;
    showCartaoOrModify = false;
    showAdicionarCartao = false;
    showEsperaMotoristaConfirmacao = false;
    showMotoristaACaminho = false;
    showEmCorridaContainer = false;
    showEmPagamentoContainer = false;
  }

  void displayRiderDetailContainer() async {
    await getPlaceDirection();
    setState(() {
      fechaTudo();
      showCabecalhoMapa = true;
      showRiderDetailContainer = true;
      bottomPaddingOfMap = 400.0;
    });
  }

  void displayRequestRideContainer() {
    setState(() {
      bottomPaddingOfMap = 230.0;
    });
  }

  void onSoQueroUmTaxiClicked() {
    setState(() {
      fechaTudo();
      showCabecalhoMapa = true;
      showRiderDetailContainer = true;
      bottomPaddingOfMap = 390.0;
      enderecoOrigem = 'Não informado';
      enderecoDestino = 'Não informado';
    });
  }

  void displayBemVindoContainer() {
    setState(() {
      fechaTudo();
      showOlaContainer = true;
      bottomPaddingOfMap = 360.0;
    });
  }

  void displayFormaPagamentoContainer() {
    setState(() {
      fechaTudo();
      showFormaPagamento = true;
      bottomPaddingOfMap = 390.0;
    });
  }

  void displayFormaPagamentoOpcoes() {
    setState(() {
      fechaTudo();
      showFormaPagamentoOpcao = true;
      bottomPaddingOfMap = 500.0;
    });
  }

  void displayCardModify() {
    setState(() {
      fechaTudo();
      showCartaoOrModify = true;
      bottomPaddingOfMap = 500.0;
    });
  }

  void displayCardAdicionar() {
    setState(() {
      fechaTudo();
      showCartaoOrModify = true;
      bottomPaddingOfMap = 500.0;
      showAdicionarCartao = true;
    });
  }

  void displayEmCorrida() {
    setState(() {
      fechaTudo();
      showCabecalhoMapa = true;
      showEmCorridaContainer = true;
      bottomPaddingOfMap = 260.0;
    });
  }

  void displayEmPagamento() {
    setState(() {
      fechaTudo();
      showCabecalhoMapa = false;
      showEmPagamentoContainer = true;
      bottomPaddingOfMap = 460.0;
    });
  }

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

  void onVeiculoEscolhidoClicked(int motoristaId) {
    getEnderecoPartida();
    setState(() {
      fechaTudo();
      showCabecalhoMapa = true;
      showEsperaMotoristaConfirmacao = true;
      this.motoristaId = motoristaId;
      bottomPaddingOfMap = 370.0;
      //enderecoOrigem = initialPos.placeName;
      print(motoristaId);
      motoristaBloc.pedeConfirmacaoMotorista(
          enderecoOrigem: enderecoOrigem,
          motoristaId: motoristaId,
          context: context);
    });
  }

  void displayMotoristaAceitouCorrida() {
    setState(() {
      fechaTudo();
      showCabecalhoMapa = true;
      showMotoristaACaminho = true;
      bottomPaddingOfMap = 370.0;
    });
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
            StreamBuilder<stateScreenEnum>(
              stream: motoristaBloc.outStateScreen,
              builder: (context, snapshot) {
                if (snapshot.data != stateScreenEnum.SCREEN_MOTORISTA_ACEITOU_VIAGEM) {
                  motoristaBloc.verificaPosicaoMotorista(context).then((value) =>
                  motoristaBloc.getPlaceDirectionDriverToPassengerBloc
                  );
                }
                else
                  motoristaBloc.getPlaceDirectionDriverToPassengerBloc();
                return StreamBuilder<DirectionDetails>(
                  stream: motoristaBloc.outTripDirectionalDetail,
                  builder: (context, snapshot) {
                    return GoogleMap(
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
                      polylines: motoristaBloc.polylineSet,
                      markers: motoristaBloc.markersSet,
                      circles: motoristaBloc.circlesSet,
                      onMapCreated: (GoogleMapController controller) {
                        _controllerGoogleMap.complete(controller);
                        newGoogleMapController = controller;
                        setState(() {
                          bottomPaddingOfMap = 350.0;
                        });
                        locatePosition();
                      },
                    );
                  }
                );
              }
            ),
            // Cabeçalho do mapa
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
            //rider detail lista de veiculo
            Container(
              child: showRiderDetailContainer
                  ? CustonPositionedRiderDetail(
                      displayRequestRideContainer: displayRequestRideContainer,
                      onFormaPagamentoClicked: displayFormaPagamentoContainer,
                      onVeiculoEscolhidoClicked: onVeiculoEscolhidoClicked,
                    )
                  : null,
            ),
            // Escolher forma de pagamento
            Container(
              child: showFormaPagamento
                  ? CustonPositionEscolherFormaPagamento(
                      onEscolherFormaPagamentoClicked:
                          displayFormaPagamentoOpcoes,
                      onCancelarFormaPagamentoClicked:
                          displayRiderDetailContainer,
                    )
                  : null,
            ),
            // Escolher forma de pagamento
            Container(
              child: showFormaPagamentoOpcao
                  ? CustonPositionEscolherFormaPagamentOpcao(
                      onEscolherFormaPagamentOpcaoClicked: (resp) {
                        print(resp);
                      },
                      onCancelarFormaPagamentoOpcaoClicked:
                          displayRiderDetailContainer,
                      onAddCardOrModify: displayCardModify,
                    )
                  : null,
            ),
            // Escolher cartao
            Container(
              child: showCartaoOrModify
                  ? CustonPositionEscolherListaCartaoModifica(
                      onCancelarFormaPagamentoOpcaoClicked:
                          displayRiderDetailContainer,
                      onAddCardOrModify: displayCardAdicionar,
                    )
                  : null,
            ),
            // Adicionar cartao
            Container(
              child: showAdicionarCartao
                  ? CustonPositionAdicionarCartao(
                      onCancelarFormaPagamentoOpcaoClicked:
                          displayRiderDetailContainer,
                    )
                  : null,
            ),
            // Esperando confirmacao motorista
            Container(
              child: showEsperaMotoristaConfirmacao
                  ? CustonPositionEsperaMotoristaConfirmacao(
                      displayEsperaMotoristaConfirmacaoContainer: () {},
                      cancelaEsperaMotoristaConfirmacaoContainer:
                          displayBemVindoContainer,
                      motoristaId: motoristaId,
                    )
                  : null,
            ),
            // Motorista a caminho
            Container(
              child: showMotoristaACaminho
                  ? CustonPositionMotoristaACaminho(
                displayMotoristaACaminhoContainer: () {},
                cancelaMotoristaACaminhoContainer: displayBemVindoContainer,
                motorista: motoristaBloc.motorista,
                percentualDesconto: passageiro.percentualDesconto.toInt(),
                motoristaBloc: motoristaBloc,
              )
                  : null,
            ),
            Container(
              child: showEmCorridaContainer
                  ? CustonPositionEmCorrida(
                displayEmCorridaContainer: () {},
                cancelaEmCorridaContainer: displayBemVindoContainer,
                motorista: motoristaBloc.motorista,
                percentualDesconto: passageiro.percentualDesconto.toInt(),
                motoristaBloc: motoristaBloc,
              )
                  : null,
            ),
            Container(
              child: showEmPagamentoContainer
                  ? CustonPositionEmPagamento(
                displayEmPagamentoContainer: () {},
                cancelaEmPagamentoContainer: displayBemVindoContainer,
                motorista: motoristaBloc.motorista,
                percentualDesconto: passageiro.percentualDesconto.toInt(),
                motoristaBloc: motoristaBloc,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void getEnderecoPartida() {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    enderecoOrigem = initialPos.placeName;
  }

  Future<void> getPlaceDirection() async {
    var initialPos = Provider.of<AppData>(context, listen: false).pickUpLocation;
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

  Future<void> getPlaceDirectionDriverToPassenger({required LatLng pickUpLatLng, required LatLng dropOffLatLng}) async {

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

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });
  }
}
/*
 var decoded = json.decode(jsonString);
 List<EntFrota> frotas = decoded['item'].map<EntFrota>(
 (map) { return EntFrota.fromJson(map)}
 ).toList()
  */
