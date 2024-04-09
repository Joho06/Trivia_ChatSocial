//import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivai_chat_social/Page/widgets/lenguajeButton.dart';

import 'LoginPage.dart'; // Importa la página Home si es necesario

class welcomePage extends StatefulWidget {
  const welcomePage({Key? key}) : super(key: key);

  @override
  _welcomePageState createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111B21),
      body: Column(
        children: [
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Image.asset(
                  'assets/images/welcome.png',
                  color: Color(0xFF000A884),
                )),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Bienvenida a whatsapp',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Lee nuestra ',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: 'Politicas de privacidad. ',
                            style: TextStyle(
                              color: Color(0xFF53D9EB),
                            ),
                          ),
                          TextSpan(
                            text:
                                'Toca "Aceptar y continuar" para aceptar los ',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              height: 1.5,
                            ),
                          ),
                          TextSpan(
                            text: 'Términos y Condiciones',
                            style: TextStyle(
                              color: Color(0xFF53D9EB),
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 100,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFF00A884),
                        foregroundColor: Color(0xFF111B21),
                        splashFactory: NoSplash.splashFactory,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text('ACEPTAR Y CONTINUAR',
                      ),
                  ),
                ),
                SizedBox(height: 50),
                LanguageButton(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
