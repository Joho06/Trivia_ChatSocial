import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            top: 15,
            left: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 0,
            child: IconButton(
              onPressed: () {
                _toggleFlash();
              },
              icon: const Icon(
                Icons.flash_off,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: 112, // Ajusta la altura según sea necesario
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      _switchCamera();
                    },
                    icon: const Icon(
                      Icons.cached_sharp,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _takePicture();
                    },
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (pictureFile != null)
            Positioned.fill(
              child: Image.file(
                File(pictureFile!.path),
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
  Widget _buildPicturePreview() {
    if (pictureFile != null) {
      return Stack(
        children: [
          Positioned.fill(
            child: Transform.scale(
              scale: _cameraController.description.lensDirection == CameraLensDirection.front ? -1.0 : 1.0,
              alignment: Alignment.center,
              child: Image.file(
                File(pictureFile!.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Lógica para guardar la imagen
                  },
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Lógica para cerrar la vista previa
                    setState(() {
                      pictureFile = null;
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox(); // Si no hay ninguna foto capturada, no muestra nada
    }
  }


  void _toggleFlash() async {
    bool isFlashOn = _cameraController.value.flashMode == FlashMode.torch;
    await _cameraController.setFlashMode(
      isFlashOn ? FlashMode.off : FlashMode.torch,
    );
    setState(() {});
  }

  void _switchCamera() async {
    await _cameraController.dispose();
    CameraDescription currentCamera = _cameraController.description;
    List<CameraDescription> cameras = await availableCameras();
    int nextCameraIndex = (currentCamera.lensDirection.index + 1) % cameras.length;
    _cameraController = CameraController(cameras[nextCameraIndex], ResolutionPreset.high);
    await _cameraController.initialize();
    setState(() {});
  }

  void _takePicture() async {
    try {
      XFile? picture = await _cameraController.takePicture();
      setState(() {
        pictureFile = picture;
      });
    } catch (e) {
      print("Error al tomar la foto: $e");
    }
  }
}
