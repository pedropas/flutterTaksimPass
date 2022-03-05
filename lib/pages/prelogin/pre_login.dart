import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taksim/componentes/custom_button.dart';
import 'package:taksim/helpers/config_screen.dart';
import '../../componentes/divider_widget.dart';

class PreLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Splash3Widget - FRAME
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SplashPass.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/taksim_logo.png',
                width: 150,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 150,
              ),
              // bem vindo
              Text(
                "Seja bem-vindo !",
                style: TextStyle(
                  fontFamily: "Montserrat Bold",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              // Ja tenho cadastro
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.90,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "JÁ TENHO CONTA",
                    style: TextStyle(
                      fontFamily: "Montserrat Bold",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BUTTON_COLOR),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // cadastre-me
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.90,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: BUTTON_COLOR),
                  ),
                  onPressed: () {},
                  child: Text(
                    "CADASTRAR-ME",
                    style: TextStyle(
                      fontFamily: "Montserrat Bold",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: DividerWidget(
                        corLinha: Colors.white54,
                      ),
                    ),
                    Text(
                      " ou ",
                      style: TextStyle(
                          fontFamily: "Montserrat Bold",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white54),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: DividerWidget(
                        corLinha: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomButton(imageName: 'assets/images/googleDark.png',
                                         comSombra: false,
                                         backGroundColor: Colors.transparent,
                           buttonFunction: googleLogin),
                    CustomButton(imageName: 'assets/images/facebookDark.png',
                        comSombra: false,
                        backGroundColor: Colors.black,
                        buttonFunction: facebookLogin),
                    CustomButton(imageName: 'assets/images/apple.png',
                        comSombra: false,
                        backGroundColor: Colors.black,
                        buttonFunction: appleLogin),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: visualizarTermoUso,
                child: Text(
                  "Ao avançar, declaro que li e concordo com os",// Termos de uso e a Politica de Privacidade. ",
                  style: TextStyle(
                    fontFamily: "Montserrat Bold",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: visualizarTermoUso,
                child: Text(
                  "Termos de uso e a Politica de Privacidade.",
                  style: TextStyle(
                    fontFamily: "Montserrat Bold",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void visualizarTermoUso()
  {
    print("Termo");
  }

  void googleLogin()
  {
    print("Tipo google");
  }

  void appleLogin()
  {
    print("Tipo Apple");
  }

  void facebookLogin()
  {
    print("Tipo facebook");
  }

  // Future<void> _signInWithGoogle() async {
  //   setIsLoading();
  //   try {
  //     // Trigger the authentication flow
  //     final googleUser = await GoogleSignIn().signIn();
  //
  //     // Obtain the auth details from the request
  //     final googleAuth = await googleUser?.authentication;
  //
  //     if (googleAuth != null) {
  //       // Create a new credential
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //
  //       // Once signed in, return the UserCredential
  //       await _auth.signInWithCredential(credential);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       error = '${e.message}';
  //     });
  //   } finally {
  //     setIsLoading();
  //   }
  // }
}
