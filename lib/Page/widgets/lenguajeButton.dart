import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../utils/coloors.dart';
import '../utils/custom_icon_button.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({Key? key}) : super(key: key);

  @override
  _LanguageButtonState createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  // Inicialmente seleccionado Español
  Locale _selectedLocale = const Locale('es', 'ES');

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
                  _changeLanguage(context, const Locale('en', 'US'));
                  Navigator.pop(context);
                },
                title: const Text(
                  'English',
                  style: TextStyle(
                    color: Coloors.greenDark,
                  ),
                ),
                selected: _selectedLocale.languageCode == 'en',
              ),
              ListTile(
                onTap: () {
                  _changeLanguage(context, const Locale('es', 'ES'));
                  Navigator.pop(context);
                },
                title: const Text(
                  'Español',
                  style: TextStyle(
                    color: Coloors.greenDark,
                  ),
                ),
                selected: _selectedLocale.languageCode == 'es',
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeLanguage(BuildContext context, Locale locale) {
    setState(() {
      _selectedLocale = locale;
    });
    // Cambiar el idioma de la aplicación
    LocaleProvider.locale = locale;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black45,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => showLanguageBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Coloors.greenDark.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language,
                color: Coloors.greenDark,
              ),
              SizedBox(width: 10),
              Text(
                _selectedLocale.languageCode == 'en'
                    ? 'English'
                    : 'Español',
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
  }
}
