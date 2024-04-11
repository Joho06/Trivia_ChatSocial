import 'package:flutter/material.dart';
import '../Screens/Ajustes/chatSetting.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AjustesPage extends StatelessWidget {
  const AjustesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //leadingWidth: 80,
        iconTheme: IconThemeData(
          color: Colors.black, // Establecer color blanco para el icono
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Ajustes',
            style: TextStyle(
              color: Colors.black, // Establecer color blanco para el texto
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),

                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/images/user/user1.jpg',
                        height: 65,
                        width: 65,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User1',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '....',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Divider(),
              InkWell(
                  onTap: () {
                    // Lógica para manejar el evento de "Cuenta"
                  },
                  child: ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.key),
                    ),
                    title: Text(
                      'Cuenta',
                      style: TextStyle(fontSize: 17),
                    ),
                    subtitle: Text(
                      'Notificación de seguridad, cambiar cuenta',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Lógica para manejar el evento de "Privacidad"
                  },
                  child: ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.lock),
                    ),
                    title: Text(
                      'Privacidad',
                      style: TextStyle(fontSize: 17),
                    ),
                    subtitle: Text(
                      'Bloquear Contactos',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatSetScreen()),
                    );
                  },
                  child: ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.chat),
                    ),
                    title: Text(
                      'Temas',
                      style: TextStyle(fontSize: 17),
                    ),
                    subtitle: Text(
                      'Tema, fondos, etc.',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Lógica para manejar el evento de "Notificación"
                  },
                  child: ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.notifications),
                    ),
                    title: Text(
                      'Notificación',
                      style: TextStyle(fontSize: 17),
                    ),
                    subtitle: Text(
                      'Tonos de mensajes',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {

                  },
                  child: ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.language_outlined),
                    ),
                    title: Text(
                      'Lenguaje',
                      style: TextStyle(fontSize: 17),
                    ),
                    subtitle: Text(
                      'Idioma de la app',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Lógica para manejar el evento de "Ayuda"
                  },
                  child: ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.help_outline),
                    ),
                    title: Text(
                      'Ayuda',
                      style: TextStyle(fontSize: 17),
                    ),
                    subtitle: Text(
                      'Centro de ayuda',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
