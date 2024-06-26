import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivai_chat_social/Page/utils/custom_elevated_button.dart';
import 'package:trivai_chat_social/Page/widgets/lenguajeButton.dart';
import 'package:trivai_chat_social/Rutas/routes.dart';

import 'LoginPage.dart';

class welcomePage extends StatefulWidget {
  const welcomePage({Key? key}) : super(key: key);

  @override
  _welcomePageState createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {

  navigateToLoginPage(context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.login,
          (route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100), // Ajusta el valor según sea necesario
                child: Image.asset(
                  'assets/images/login.png',
                  //color: const Color(0xff000a884),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: Column(
              children: [
                 const Text(
                  'Bienvenidos a Trivai',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        text: 'Lee nuestra ',
                        style: TextStyle(
                          color: Colors.black,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: 'Politicas de privacidad. ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Toca "Aceptar y continuar" para aceptar los ',
                            style: TextStyle(
                              color: Colors.black,
                              height: 1.5,
                            ),
                          ),
                          TextSpan(
                            text: 'Términos y Condiciones',
                            style: TextStyle(
                              color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 100,
                  child: CustomElevatedButton(
                    onPressed: () => navigateToLoginPage(context),
                    text: 'ACEPTAR Y CONTINUAR',
                   // Cambia el color según lo deseado
                  ),

                ),
                const SizedBox(height: 20),
                const LanguageButton(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
