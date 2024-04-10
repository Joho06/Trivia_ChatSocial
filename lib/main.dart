import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivai_chat_social/Page/AjustesPage.dart';
import 'package:trivai_chat_social/Page/HomePage.dart';
import 'package:trivai_chat_social/Page/LoginPage.dart';
import 'package:trivai_chat_social/Page/welcomePage.dart';
import 'package:trivai_chat_social/Rutas/routes.dart';
import 'Screens/cameraScreen.dart';
import 'firebase_options.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Color(0xFF075E55),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),
      dark: ThemeData.dark(),
      initial: AdaptiveThemeMode.light,
      builder: (lightTheme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        initialRoute: Routes.welcome, // Usa la constante definida en tu archivo de rutas
        onGenerateRoute: Routes.onGenerateRoute, // Usa la función definida en tu archivo de rutas
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // Inglés
          const Locale('es', 'ES'), // Español
          // Agrega más locales según sea necesario
        ],
        // La localización inicial de la aplicación
        locale: const Locale('es', 'ES'), // Por defecto en Español
      ),
    );
  }
}
