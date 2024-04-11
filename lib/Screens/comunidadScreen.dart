import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComunidadScreen extends StatefulWidget {
  const ComunidadScreen({Key? key}) : super(key: key);

  @override
  State<ComunidadScreen> createState() => _ComunidadScreenState();
}

class _ComunidadScreenState extends State<ComunidadScreen> {
  List<bool> likes = [false, false, false, false]; // Estado de "me gusta" para cada publicación
  List<String> nombres = [
    'Michael Graves',
    'Vince Neil',
    'Niky Sixx',
    'Tomme Lee',
  ];

  List<String> imagenesUsuario = [
    'assets/images/user/user1.jpg',
    'assets/images/user/user2.jpg',
    'assets/images/user/user3.jpg',
    'assets/images/user/user4.jpg',
  ];

  List<String> imagenesPublicacion = [
    'assets/images/publish/img1.jpg',
    'assets/images/publish/img2.jpg',
    'assets/images/publish/img3.jpg',
    'assets/images/publish/img4.jpg',
  ];

  TextEditingController comentarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: nombres.length, // Número total de publicaciones
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(imagenesUsuario[index]),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        nombres[index],
                        style: const TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(imagenesPublicacion[index]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: likes[index] ? Colors.red : null,
                        ),
                        onPressed: () {
                          setState(() {
                            likes[index] = !likes[index];
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.comment_outlined),
                        onPressed: () {
                          _agregarComentario(context, index);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                _buildComentarios(index),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildComentarios(int index) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('comentarios')
          .where('index', isEqualTo: index.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        var comentarios = snapshot.data!.docs;
        return Column(
          children: comentarios.map<Widget>((comentario) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(imagenesUsuario[index]),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nombres[index],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          comentario['comentario'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _agregarComentario(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: Colors.white70,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: comentarioController,
                  decoration: InputDecoration(
                    hintText: 'Escribe tu comentario',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String comentarioText = comentarioController.text.trim();
                        if (comentarioText.isNotEmpty) {
                          _guardarComentario(comentarioText, index);
                          comentarioController.clear();
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Por favor, escribe tu comentario'),
                            ),
                          );
                        }
                      },
                      child: Text('Enviar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _guardarComentario(String comentario, int index) async {
    try {
      await FirebaseFirestore.instance.collection('comentarios').add({
        'comentario': comentario,
        'index': index.toString(), // Agregar el índice de la publicación para identificarla
      });
    } catch (error) {
      print('Error al guardar el comentario en Firestore: $error');
      throw Exception('Error al guardar el comentario en Firestore');
    }
  }
}