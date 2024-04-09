//import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class ChatSetScreen extends StatefulWidget {
  const ChatSetScreen({Key? key}) : super(key: key);

  @override
  _ChatSetScreenState createState() => _ChatSetScreenState();
}

class _ChatSetScreenState extends State<ChatSetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Establecer color blanco para el icono
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Chats',
            style: TextStyle(
              color: Colors.white, // Establecer color blanco para el texto
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Pantalla',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                _showThemeDialog(context);
              },
              child: const ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(top: 1, right: 8),
                  child: Icon(Icons.sunny),
                ),
                title: Text(
                  'Tema',
                  style: TextStyle(fontSize: 17),

                ),

              ),
            ),
            InkWell(
              onTap: () {
                // Lógica para manejar el evento de "Fondo de pantalla"
              },
              child: const ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(top: 1,right: 8),
                  child: Icon(Icons.image_outlined),
                ),
                title: Text(
                  'Fondo de pantalla',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Elige un tema'),
          content: Column(
            mainAxisSize: MainAxisSize.min,

          ),
        );
      },
    );
  }
}
