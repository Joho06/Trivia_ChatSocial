//import 'package:chatrivaiapp/Screens/ChatSamples/ChatBottomBar.dart';
import 'package:flutter/material.dart';
import 'ChatSamples/ChatSample.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/fondo.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 80),
            child: Column(
              children: [
                Container(
                  width: 300,
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF3C2),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    "Los mensajes estan cifrados de extremo a extremo. Nadie fuera de este chat, puede leerlos ni escucharlos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                        color: Colors.black,
                    ),
                  ),
                ),
                ChatSample(),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
