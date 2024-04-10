import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:trivai_chat_social/Page/HomePage.dart';
import 'package:trivai_chat_social/Page/utils/custom_text_field.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key, this.profileImageUrl}) : super(key: key);

  final String? profileImageUrl;

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;

  late TextEditingController usernameController;
  late TextEditingController usermailController;

  get userController => null;

  @override
  void initState() {
    usernameController = TextEditingController();
    usermailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    usermailController.dispose();
    super.dispose();
  }

  saveUserDataToFirebase() async {
    String username = usernameController.text;
    String mail = usermailController.text;
    if (username.isEmpty) {
      showAlertDialog(
        context: context,
        message: 'Por favor ingresa tu nombre de perfil',
      );
      return;
    } else if (username.length < 3 || username.length > 20) {
      showAlertDialog(
        context: context,
        message: 'La longitud de un nombre de usuario debe estar entre 3 y 20',
      );
      return;
    }

    try {
      // Guardar los datos del usuario en Firestore
      await FirebaseFirestore.instance.collection('usuarios').doc().set({
        'username': username,
        'mail': mail,
        'profileImage': imageCamera != null || imageGallery != null
            ? await uploadImageToStorage()
            : widget.profileImageUrl ?? '',
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Éxito'),
            content: Text('Los datos se guardaron exitosamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()), // Reemplaza "NuevaPagina" con el nombre de tu clase de página
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Hubo un error al guardar los datos. Por favor, inténtalo de nuevo.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<String> uploadImageToStorage() async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('user_profile_images').child('image_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageReference.putFile(imageCamera != null ? imageCamera! : File.fromRawPath(imageGallery!));
      final String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Error al subir la imagen a Firebase Storage: $error');
      throw Exception('Error al subir la imagen a Firebase Storage');
    }
  }

  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt_rounded),
                title: Text('Cámara'),
                onTap: () {
                  pickImageFromCamera();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera_back_rounded),
                title: Text('Galería'),
                onTap: () async {
                  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (image == null) return;
                  setState(() {
                    imageGallery = File(image.path).readAsBytesSync();
                    imageCamera = null;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      setState(() {
        imageCamera = File(image.path);
        imageGallery = null;
      });
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Color blanco
        title: Text('Información de perfil'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0), // Altura preferida del widget
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: const Text(
              'Proporcione su nombre y una foto de perfil opcional.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
          ),
        ),
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: imagePickerTypeBottomSheet,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,
                  border: Border.all(
                    color: imageCamera == null && imageGallery == null ? Colors.transparent : Colors.black38,
                  ),
                ),
                child: ClipOval(
                  child: imageCamera != null || imageGallery != null || widget.profileImageUrl != null
                      ? Image.memory(
                    imageGallery ?? Uint8List(0),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  )
                      : Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: usernameController,
                  hintText: 'Escribe tu nombre aquí',
                  textAlign: TextAlign.start,
                  autoFocus: true,
                ),
                SizedBox(height: 20), // Espacio entre los campos de entrada
                CustomTextField(
                  controller: usermailController,
                  hintText: 'Escribe tu correo aquí',
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20), // Espacio entre los campos de entrada
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'YYYY', // Placeholder para el año
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        // Aquí puedes añadir validaciones específicas para el año si lo deseas
                      ),
                    ),
                    SizedBox(width: 10), // Espacio entre los campos
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'MM', // Placeholder para el mes
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        // Aquí puedes añadir validaciones específicas para el mes si lo deseas
                      ),
                    ),
                    SizedBox(width: 10), // Espacio entre los campos
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'DD', // Placeholder para el día
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        // Aquí puedes añadir validaciones específicas para el día si lo deseas
                      ),
                    ),
                  ],
                ),

              ],
            ),

            const SizedBox(height: 10),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 100,
        height: 40,
        child: FloatingActionButton(
          onPressed: saveUserDataToFirebase,
          child: Text('Siguiente'),
        ),
      ),

    );
  }
}

void showAlertDialog({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alerta'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
