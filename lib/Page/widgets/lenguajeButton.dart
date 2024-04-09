import 'package:flutter/material.dart';
import 'package:trivai_chat_social/Page/utils/custom_theme_extension.dart';
import 'package:flutter/material.dart'; // Importa NoSplash

import '../utils/coloors.dart';
import '../utils/custom_icon_button.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({Key? key}) : super(key: key);

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Coloors.backgroundDark,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                  color: Coloors.greenDark,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  CustomIconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icons.close,
                    iconColor: Coloors.greenDark,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Selecciona el lenguaje',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Coloors.greenDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(
                thickness: .5,
                color: Coloors.greyDark.withOpacity(0.3),
              ),
              ListTile(
                onTap: () {
                  _changeLanguage(context, 'en');
                  Navigator.pop(context);
                },
                title: Text(
                  'English',
                  style: TextStyle(
                    color: Coloors.greenDark,
                  ),
                ),
                selected: _isLanguageSelected(context, 'en'),
              ),
              ListTile(
                onTap: () {
                  _changeLanguage(context, 'es');
                  Navigator.pop(context);
                },
                title: Text(
                  'Español',
                  style: TextStyle(
                    color: Coloors.greenDark,
                  ),
                ),
                selected: _isLanguageSelected(context, 'es'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    final locale = Locale(languageCode);
    LocaleProvider.locale = locale; // Cambiar el idioma aquí
  }

  bool _isLanguageSelected(BuildContext context, String languageCode) {
    return LocaleProvider.locale?.languageCode == languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => showLanguageBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Coloors.greenDark.withOpacity(0.2), // Ajustar el color de resaltado
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.language,
                color: Coloors.greenDark,
              ),
              SizedBox(width: 10),
              Text(
                'Español',
                style: TextStyle(
                  color: Coloors.greenDark,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down,
                color: Coloors.greenDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocaleProvider {
  static Locale? _locale;

  static Locale? get locale => _locale;

  static set locale(Locale? value) {
    _locale = value;
    // Aquí puedes realizar cualquier acción adicional después de cambiar el idioma, como recargar la interfaz de usuario
  }
}
