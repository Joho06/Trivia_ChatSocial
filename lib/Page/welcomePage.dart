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
                  'Bienvenidos a Trivai',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF0066FF),
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
                          color: const Color(0xff000a884),
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: 'Politicas de privacidad. ',
                            style: TextStyle(
                              color: Color(0xFF1100FF),
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
                              color: Color(0xFF1100FF),
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
