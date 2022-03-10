import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:http_pac/http_pac.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksim/pages/apresentacao/on_board.dart';
import 'package:taksim/pages/base/base_screen.dart';
import 'package:taksim/pages/base/page_store.dart';
import 'package:taksim/pages/login/login_screen.dart';

import 'helpers/config_screen.dart';
import 'helpers/network_const.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

Future<void> setupLocators() async
{
  GetIt.I.registerSingleton(PageStore());
//  GetIt.I.registerSingleton(MotoristaManagerStore());
  GetIt.I.registerSingleton(HttpPAC(chaveIV: CHAVE_IV
      , urlBase: URL_BASE
      , urlBaseDebug: URL_BASE_DEBUG
      , baseAppUrl: BASE_APP_URL
      , isDebug: IS_DEBUG));
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton(sharedPreferences);

  //GetIt.I.registerSingleton(MethodChannel('USB_CHANNEL'));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taksim Passageiro',
      theme: ThemeData(
        primarySwatch: BUTTON_COLOR,// Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Taksim Passageiro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    setupLocators();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:BaseScreen(),
    );
  }
}
