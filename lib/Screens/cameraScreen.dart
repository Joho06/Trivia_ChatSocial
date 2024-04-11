import 'dart:typed_data';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? imageCamera;
  Uint8List? imageGallery;

  Future<String> uploadImageToStorage() async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('image_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageReference.putFile(
          imageCamera != null ? imageCamera! : File.fromRawPath(imageGallery!));
      final String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Error al subir la imagen a Firebase Storage: $error');
      throw Exception('Error al subir la imagen a Firebase Storage');
    }
  }

  Future<void> pickImageFromCamera() async {
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

  void showAlertDialog({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call the imagePickerTypeBottomSheet function here
            imagePickerTypeBottomSheet(context);
          },
          child: Text('Select Image'),
        ),
      ),
    );
  }

  void imagePickerTypeBottomSheet(BuildContext context) {
    showModalBottomSheet(
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
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image == null) return;
                  setState(() {
                    imageGallery =
                        File(image.path).readAsBytesSync();
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
}
