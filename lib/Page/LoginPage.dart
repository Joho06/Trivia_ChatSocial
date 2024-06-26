import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivai_chat_social/Page/utils/auth/controller.dart';
import 'package:trivai_chat_social/Page/utils/coloors.dart';
import 'package:trivai_chat_social/Page/utils/custom_elevated_button.dart';
import 'package:trivai_chat_social/Page/utils/custom_icon_button.dart';
import 'package:trivai_chat_social/Page/utils/custom_text_field.dart';
import 'package:trivai_chat_social/Page/utils/custom_theme_extension.dart';
import 'package:trivai_chat_social/Page/utils/show_alert.dart';

import 'package:country_picker/country_picker.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  void sendCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;

    if (phoneNumber.isEmpty) {
      return showAlertDialog(
        context: context,
        message: "Por favor, introduzca su número de teléfono",
      );
    } else if (phoneNumber.length < 9) {
      return showAlertDialog(
        context: context,
        message:
        'El número de teléfono que ingresaste es demasiado corto para el país.: $countryName\n\nInclude your area code if you haven\'t',
      );
    } else if (phoneNumber.length > 10) {
      return showAlertDialog(
        context: context,
        message:
        "El número de teléfono que ingresaste es demasiado largo para el país.: $countryName",
      );
    }

    ref.read(authControllerProvider).sendSmsCode(
      context: context,
      phoneNumber: "+$countryCode$phoneNumber",
    );
  }

  void showCountryPickerBottomSheet() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['EC'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        backgroundColor: Theme.of(context).backgroundColor,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        textStyle: TextStyle(color: context.theme?.greyColor),
        inputDecoration: InputDecoration(
          labelStyle: TextStyle(color: context.theme?.greyColor),
          prefixIcon: const Icon(
            Icons.language,
            color: Coloors.greyDark,
          ),
          hintText: 'Buscar país por código o nombre',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: context.theme?.greyColor?.withOpacity(0.2) ?? Colors.transparent,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Coloors.greenDark,
            ),
          ),
        ),
      ),
      onSelect: (country) {
        countryNameController.text = country.name;
        countryCodeController.text = country.phoneCode;
      },
    );
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Ecuador');
    countryCodeController = TextEditingController(text: '593');
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Ingrese su número telefónico',
          style: TextStyle(
            color: context.theme?.authAppbarTextColor,
          ),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            onPressed: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Trivai deberá verificar su número.',
                style: TextStyle(
                  color: Colors.black,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: "¿Cuál es su número?",
                    style: TextStyle(
                        color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextField(
              onTap: showCountryPickerBottomSheet,
              controller: countryNameController,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
                size: 22,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextField(
                    onTap: showCountryPickerBottomSheet,
                    controller: countryCodeController,
                    prefixText: '+',
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: phoneNumberController,
                    hintText: 'teléfono',
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Se pueden aplicar cargos',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: sendCodeToPhone,
        text: 'Siguiente',
        buttonWidth: 120,
      ),
    );
  }
}
