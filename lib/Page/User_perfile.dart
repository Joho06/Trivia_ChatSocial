import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:trivai_chat_social/Page/HomePage.dart';
import 'package:trivai_chat_social/Page/utils/custom_elevated_button.dart';
import 'package:trivai_chat_social/Page/utils/custom_text_field.dart';
import 'package:date_field/date_field.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key, this.profileImageUrl}) : super(key: key);

  final String? profileImageUrl;

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  File? selectedImage; // Variable para manejar la imagen seleccionada
  DateTime? selectedDate; // Variable para manejar la fecha seleccionada

  late TextEditingController usernameController;
  late TextEditingController usermailController;

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
      // Subir la imagen al almacenamiento de Firebase si está presente
      String imageUrl = widget.profileImageUrl ?? '';
      if (selectedImage != null) {
        imageUrl = await uploadImageToStorage(selectedImage!);
      }

      // Guardar los datos del usuario en Firestore
      await FirebaseFirestore.instance.collection('usuarios').doc().set({
        'username': username,
        'mail': mail,
        'profileImage': imageUrl,
        'birthdate': selectedDate != null ? selectedDate!.toIso8601String() : null, // Guardar la fecha como un String en Firestore
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
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

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('user_profile_images').child('image_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageReference.putFile(imageFile);
      final String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Error al subir la imagen a Firebase Storage: $error');
      throw Exception('Error al subir la imagen a Firebase Storage');
    }
  }

  pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      setState(() {
        selectedImage = File(image.path); // Actualiza la imagen seleccionada
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
              'Proporcione su nombre, una foto de perfil opcional y su fecha de nacimiento.',
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
              onTap: () async {
                final image = await ImagePicker().pickImage(source: ImageSource.camera);
                if (image == null) return;
                setState(() {
                  selectedImage = File(image.path); // Actualiza la imagen seleccionada
                });
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,
                  border: Border.all(
                    color: selectedImage == null ? Colors.transparent : Colors.black38,
                  ),
                ),
                child: ClipOval(
                  child: selectedImage != null || widget.profileImageUrl != null
                      ? Image.file(
                    selectedImage ?? File(''), // Muestra la imagen seleccionada
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
                DateTimeFormField(
                  decoration: const InputDecoration(
                    labelText: 'Ingresa tu fecha de nacimiento',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)), // Resta 100 años
                  lastDate: DateTime.now(), // Hasta la fecha actual
                  initialPickerDateTime: DateTime.now().subtract(const Duration(days: 365 * 20)), // Resta 20 años como fecha inicial
                  onChanged: (DateTime? value) {
                    setState(() {
                      selectedDate = value; // Actualiza la fecha seleccionada
                    });
                  },
                ),

              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: saveUserDataToFirebase,
        text: 'Siguiente',
        buttonWidth: 120,
      ),

    );
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
}
