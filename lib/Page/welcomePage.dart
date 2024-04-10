import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivai_chat_social/Page/widgets/lenguajeButton.dart';

import 'LoginPage.dart';

class welcomePage extends StatefulWidget {
  const welcomePage({Key? key}) : super(key: key);

  @override
  _welcomePageState createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111B21),
      body: Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Image.asset(
                  'assets/images/login.png',
                  color: const Color(0xff000a884),
                )),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: Column(
              children: [
                 const Text(
                  'Bienvenida a Trivai',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF53D9EB),
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
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF00A884),
                        foregroundColor: const Color(0xFF111B21),
                        splashFactory: NoSplash.splashFactory,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text('ACEPTAR Y CONTINUAR',
                      ),
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
