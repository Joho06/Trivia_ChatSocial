import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trivai_chat_social/Page/User_perfile.dart';

import '../Screens/chatScreen.dart';
import '../Screens/comunidadScreen.dart';
import '../Screens/statusScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  File? imageCamera;
  Uint8List? imageGallery;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'TRIVAI APP',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 0, right: 1),
            child: Row(
              children: [
                SizedBox(width: 20),
                Icon(
                  Icons.search,
                  size: 28,
                ),
              ],
            ),
          ),
          PopupMenuButton(
            onSelected: (selected) {
              if (selected == 'Ajustes') {
                Navigator.pushNamed(context, 'ajustes');
              }
            },
            elevation: 10,
            padding: EdgeInsets.symmetric(vertical: 1),
            iconSize: 28,
            offset: Offset(0, 50),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Ajustes',
                child: Text(
                  'Ajustes',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChatScreen(),
          ComunidadScreen(),
          StatusScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
        child: BottomAppBar(
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(),
            unselectedLabelStyle:
            Theme.of(context).textTheme.caption, // Establece el estilo...
            tabs: [
              Tab(
                icon: Opacity(
                  opacity: _tabController.index == 0 ? 1.0 : 0.6,
                  child: Icon(Icons.chat_outlined,
                      color: Theme.of(context).textTheme.caption!.color,
                      size: 24),
                ),
                child: Text(
                  'ChatIA',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.caption!.color,
                      fontSize: 14),
                ),
              ),
              Tab(
                icon: Opacity(
                  opacity: _tabController.index == 2 ? 1.0 : 0.6,
                  child: Icon(Icons.groups_outlined,
                      color: Theme.of(context).textTheme.caption!.color,
                      size: 24),
                ),
                child: Text(
                  'Social',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.caption!.color,
                      fontSize: 14),
                ),
              ),
              Tab(
                icon: Opacity(
                  opacity: _tabController.index == 1 ? 1.0 : 0.6,
                  child: Icon(Icons.circle_notifications_outlined,
                      color: Theme.of(context).textTheme.caption!.color,
                      size: 24),
                ),
                child: Text(
                  'Historias',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.caption!.color,
                      fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _tabController.index == 3
          ? floatingActionButton(Icon(Icons.message))
          : _tabController.index == 1
          ? floatingActionButtonEdit(
          Icon(Icons.edit), Icon(Icons.camera_alt))
          : _tabController.index == 2
          ? floatingActionButton(Icon(Icons.camera_alt))
          : Container(),
    );
  }

  Widget floatingActionButton(Icon icon) {
    return FloatingActionButton(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      child: icon,
      onPressed: () {
        imagePickerTypeBottomSheet();
      },
    );
  }

  Widget floatingActionButtonEdit(Icon editIcon, Icon cameraIcon) {
    return Column(
      children: <Widget>[
        FloatingActionButton(
          foregroundColor: const Color(0xff49646c),
          backgroundColor: const Color(0xffebf4fc), // #128C7E
          child: editIcon,
          onPressed: () {},
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          child: cameraIcon,
          onPressed: () {
            imagePickerTypeBottomSheet();
          },
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
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

}