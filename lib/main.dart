import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivai_chat_social/Page/AjustesPage.dart';
import 'package:trivai_chat_social/Page/HomePage.dart';
import 'package:trivai_chat_social/Page/LoginPage.dart';
import 'package:trivai_chat_social/Page/welcomePage.dart';
import 'Screens/cameraScreen.dart';
import 'firebase_options.dart';


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
        initialRoute: "/",
        routes: {
          "/": (context) => welcomePage(),
          "Ajustes": (context) => AjustesPage(),
          "Home": (context)=> HomePage(),
          "Login": (context)=> LoginPage(),
          //"Registrar": (context)=> RegisterPage(),
        },
      ),
    );
  }
}