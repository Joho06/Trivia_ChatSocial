import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivai_chat_social/Page/User_perfile.dart';
import 'package:trivai_chat_social/Page/utils/auth/controller.dart';
import 'package:trivai_chat_social/Page/utils/custom_icon_button.dart';
import 'package:trivai_chat_social/Page/utils/custom_text_field.dart';
import 'package:trivai_chat_social/Page/utils/custom_theme_extension.dart';
import 'package:trivai_chat_social/Page/welcomePage.dart';


class VerificationPage extends StatefulWidget {
  const VerificationPage({
    Key? key,
    required this.smsCodeId,
    required this.phoneNumber,
  }) : super(key: key);

  final String smsCodeId;
  final String phoneNumber;

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  WidgetRef? get ref => null;
  bool verificationSuccess = false;

  // Elimina la lógica de verificación automática
  void verifySmsCode(
      BuildContext context,
      WidgetRef ref,
      String smsCode,
      ) {

    // Supongamos que authControllerProvider devuelve un Provider del controlador de autenticación.
    // Aquí deberías llamar al método de verificación del código SMS del controlador de autenticación.
    // Estableceremos verificationSuccess en true o false dependiendo del resultado de la verificación.
    bool verifySmsCode(
        BuildContext context,
        WidgetRef ref,
        String smsCode,
        ) {
      // Supongamos que authControllerProvider devuelve un Provider del controlador de autenticación.
      // Aquí deberías llamar al método de verificación del código SMS del controlador de autenticación.
      // Estableceremos verificationSuccess en true o false dependiendo del resultado de la verificación.
      bool verified = ref.read(authControllerProvider as ProviderListenable<bool>);

      setState(() {
        verificationSuccess = verified;
      });

      return verified;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Veriica tu número',
          style: TextStyle(
            color: context.theme?.authAppbarTextColor,
          ),
        ),
        actions: [
          CustomIconButton(
            onPressed: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    const TextSpan(
                      text:
                      "Has intentado registrarte +59398557785. antes de solicitar un SMS o Llamada con tu código.",
                    ),
                    TextSpan(
                      text: "Wrong number?",
                      style: TextStyle(
                        color: context.theme?.blueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: CustomTextField(
                hintText: "- - -  - - -",
                fontSize: 30,
                autoFocus: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 6 && ref != null) {
                    // Cuando se complete la verificación manualmente, puedes agregar la lógica de navegación aquí
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Ingrese el codigo de 6 dígitos',
              style: TextStyle(color: context.theme?.greyColor),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.message, color: context.theme?.greyColor),
                const SizedBox(width: 20),
                Text(
                  'Reenveriar SMS',
                  style: TextStyle(
                    color: context.theme?.greyColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              color: context.theme?.greyColor!.withOpacity(.2),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: context.theme?.greyColor),
                const SizedBox(width: 20),
                Text(
                  'Llamar',
                  style: TextStyle(
                    color: context.theme?.greyColor,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Redirigir a la siguiente pantalla cuando se presione el botón "Continue"
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoPage()));
              },
              child: Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}
