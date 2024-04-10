import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trivai_chat_social/Page/HomePage.dart';
import 'package:trivai_chat_social/Page/utils/auth/controller.dart';
import 'package:trivai_chat_social/Page/utils/custom_elevated_button.dart';
import 'package:trivai_chat_social/Page/utils/custom_text_field.dart';
import 'package:trivai_chat_social/Page/utils/show_alert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  ProviderRef? get ref => null;

  saveUserDataToFirebase() {
    String username = usernameController.text;
    if (username.isEmpty) {
      return showAlertDialog(
        context: context,
        message: 'Porfavor ingresa tu nombre de perfil',
      );
    } else if (username.length < 3 || username.length > 20) {
      return showAlertDialog(
        context: context,
        message: 'La longitud de un nombre de usuario debe estar entre 3 y 20',
      );
    }

    // Verifica que ref no sea nulo antes de usarlo
    if (ref != null) {
      ref!.read(authControllerProvider).saveUserInfoToFirestore(
        username: username,
        profileImage: imageCamera ?? imageGallery ?? widget.profileImageUrl ?? '',
        context: context,
        mounted: mounted,

      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      print('Error: ref is null');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }


  }

  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true, // Para evitar que el modal ocupe toda la pantalla
      context: context,
      builder: (context) {
        return Material( // Utiliza Material para especificar el color de fondo
          color: Colors.white, // Color de fondo deseado
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 10,
              ),
              SizedBox(height: 10), // Espacio entre la imagen y las opciones de selección
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    'Foto de perfil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Color del texto negro
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const SizedBox(width: 20),
                  imagePickerIcon(
                    onTap: pickImageFromCamera,
                    icon: Icons.camera_alt_rounded,
                    text: 'Camara',
                  ),
                  const SizedBox(width: 15),
                  imagePickerIcon(
                    onTap: () async {
                      Navigator.pop(context);
                      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      setState(() {
                        imageGallery = File(image.path).readAsBytesSync();
                        imageCamera = null;
                      });
                    },
                    icon: Icons.photo_camera_back_rounded,
                    text: 'Galeria',
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }




  pickImageFromCamera() async {
    try {
      Navigator.pop(context);
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

  imagePickerIcon({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon,   color: Colors.black,),
          iconSize: 40,
          padding: EdgeInsets.zero,
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Información de perfil',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Text(
              'Proporcione su nombre y una foto de perfil opcional.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: imagePickerTypeBottomSheet,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38, // Color de fondo del círculo
                  border: Border.all(
                    color: imageCamera == null && imageGallery == null
                        ? Colors.transparent
                        :  Colors.black38,
                  ),
                ),
                child: ClipOval(
                  child: imageCamera != null || imageGallery != null || widget.profileImageUrl != null
                      ? Image.network(
                    widget.profileImageUrl ?? '',
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  )
                      : Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                    color: imageCamera == null && imageGallery == null && widget.profileImageUrl == null
                        ? Colors.black
                        : Colors.black,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: CustomTextField(
                    controller: usernameController,
                    hintText: 'Escribe tu nombre aquí',
                    textAlign: TextAlign.start,
                    autoFocus: true,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
              ],
            ),
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
}
/*class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({super.key, this.profileImageUrl});

  final String? profileImageUrl;

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;

  late TextEditingController usernameController;

  saveUserDataToFirebase() {
    String username = usernameController.text;
    if (username.isEmpty) {
      return showAlertDialog(
        context: context,
        message: 'Porfavor ingresa tu nombre de perfil',
      );
    } else if (username.length < 3 || username.length > 20) {
      return showAlertDialog(
        context: context,
        message: 'La longitud de un nombre de usuario debe estar entre 3 y 20',
      );
    }

    ref.read(authControllerProvider).saveUserInfoToFirestore(
      username: username,
      profileImage:
      imageCamera ?? imageGallery ?? widget.profileImageUrl ?? '',
      context: context,
      mounted: mounted,
    );
  }

  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ShortHBar(),
            Row(
              children: [
                const SizedBox(width: 20),
                const Text(
                  'Foto de perfil',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                CustomIconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.close,
                ),
                const SizedBox(width: 15),
              ],
            ),
            Divider(
              color: context.theme?.greyColor!.withOpacity(.3),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(width: 20),
                imagePickerIcon(
                  onTap: pickmageFromCamera,
                  icon: Icons.camera_alt_rounded,
                  text: 'Camara',
                ),
                const SizedBox(width: 15),
                imagePickerIcon(
                  onTap: () async {
                    log('hello');
                    Navigator.pop(context);
                    final image = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ImagePickerPage(),
                      ),
                    );
                    if (image == null) return;
                    setState(() {
                      imageGallery = image;
                      imageCamera = null;
                    });
                  },
                  icon: Icons.photo_camera_back_rounded,
                  text: 'Galeria',
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  pickmageFromCamera() async {
    try {
      Navigator.pop(context);
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageCamera = File(image!.path);
        imageGallery = null;
      });
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  imagePickerIcon({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        CustomIconButton(
          onPressed: onTap,
          icon: icon,
          iconColor: Coloors.greenDark,
          minWidth: 50,
          border: Border.all(
            color: context.theme!.greyColor!.withOpacity(.2),
            width: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            color: context.theme?.greyColor,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Información de perfil',
          style: TextStyle(
            color: context.theme?.authAppbarTextColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Proporcione su nombre y una foto de perfil opcional.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.theme?.greyColor,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: imagePickerTypeBottomSheet,
              child: Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme?.photoIconBgColor,
                  border: Border.all(
                    color: imageCamera == null && imageGallery == null
                        ? Colors.transparent
                        : context.theme!.greyColor!.withOpacity(.4),
                  ),
                  image: imageCamera != null ||
                      imageGallery != null ||
                      widget.profileImageUrl != null
                      ? DecorationImage(
                    fit: BoxFit.cover,
                    image: imageGallery != null
                        ? MemoryImage(imageGallery!)
                        : widget.profileImageUrl != null
                        ? NetworkImage(widget.profileImageUrl!)
                        : FileImage(imageCamera!) as ImageProvider,
                  )
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                    color: imageCamera == null &&
                        imageGallery == null &&
                        widget.profileImageUrl == null
                        ? context.theme?.photoIconColor
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: CustomTextField(
                    controller: usernameController,
                    hintText: 'Escribe tu nombre aquí',
                    textAlign: TextAlign.start,
                    autoFocus: true,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: context.theme?.photoIconColor,
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: saveUserDataToFirebase,
        text: 'SIGUIENTE',
        buttonWidth: 90,
      ),
    );
  }
}*/