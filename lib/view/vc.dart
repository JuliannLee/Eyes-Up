// ignore: depend_on_referenced_packages
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:p01/view/bottomnav.dart';

class VCscreenDisa extends StatefulWidget {
  const VCscreenDisa({Key? key}) : super(key: key);

  @override
  State<VCscreenDisa> createState() => _VCscreenDisaState();
}

class _VCscreenDisaState extends State<VCscreenDisa> {
  late List<CameraDescription> cameras;
  late Future<void> cameraInitialization;
  late CameraController cameraController;

  int direction = 0;

  @override
  void initState() {
    super.initState();
    cameraInitialization = initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await cameraController.initialize();
    // ignore: empty_catches
    } catch (e) {
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: cameraInitialization,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && cameraController.value.isInitialized) {
          return Scaffold(
            body: Stack(
              children: [
                CameraPreview(cameraController),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      direction = direction == 0 ? 1 : 0;
                      initializeCamera();
                    });
                  },
                  child: buttonFlip(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const MyHomePageD();
                        },
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset('assets/images/decline.png',
                          height: 80, width: 80),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
  Widget buttonFlip(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 75,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class VCscreenVolun extends StatefulWidget {
  const VCscreenVolun({Key? key}) : super(key: key);

  @override
  State<VCscreenVolun> createState() => _VCscreenVolunState();
}

class _VCscreenVolunState extends State<VCscreenVolun> {
  late List<CameraDescription> cameras;
  late Future<void> cameraInitialization2;
  late CameraController? cameraController2;

  int direction = 0;

  @override
  void initState() {
    super.initState();
    cameraInitialization2 = initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();

    cameraController2 = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await cameraController2!.initialize();
    // ignore: empty_catches
    } catch (e) {
    }
  }

  @override
  void dispose() {
    cameraController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: cameraInitialization2,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            cameraController2 != null &&
            cameraController2!.value.isInitialized) {
          return Scaffold(
            body: Stack(
              children: [
                CameraPreview(cameraController2!),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      direction = direction == 0 ? 1 : 0;
                      initializeCamera();
                    });
                  },
                  child: buttonFlip(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const MyHomePageV();
                        },
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset('assets/images/decline.png',
                          height: 80, width: 80),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child:
                      buttonMute(Icons.mic_off, Alignment.bottomRight),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buttonFlip(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 75,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget buttonMute(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          right: 75,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}