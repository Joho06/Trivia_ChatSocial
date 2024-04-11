import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatBottomBar extends StatefulWidget {
  @override
  _ChatBottomBarState createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  File? imageCamera;
  Uint8List? imageGallery;
  bool _isTyping = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (text) {
                        setState(() {
                          _isTyping = text.isNotEmpty;
                        });
                      },
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Mensaje",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.attachment_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15),
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.black87,
                      size: 30,
                    ),
                    onPressed: () {
                      imagePickerTypeBottomSheet();
                    },
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print('Enviando...');
              _controller.clear();
              setState(() {
                _isTyping = false;
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF00887A),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                _isTyping ? Icons.send : Icons.mic,
                size: 25,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
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
      print('Error al tomar la foto: $e');
      showAlertDialog(context: context, message: e.toString());
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

  Future<void> uploadImageToStorage() async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('user_profile_images').child('image_${DateTime.now().millisecondsSinceEpoch}.jpg');
      if (imageCamera != null) {
        await storageReference.putFile(imageCamera!);
      } else if (imageGallery != null) {
        await storageReference.putData(imageGallery!);
      } else {
        throw Exception('No se ha seleccionado ninguna imagen.');
      }
    } catch (error) {
      print('Error al subir la imagen a Firebase Storage: $error');
      throw Exception('Error al subir la imagen a Firebase Storage');
    }
  }

  void showAlertDialog({BuildContext? context, String? message}) {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message ?? ''),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
