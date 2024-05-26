import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cars7/preview_screen.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.cameras});

  final List<CameraDescription> cameras;
  
  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  var _flashMode = FlashMode.off;

  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();

    if (widget.cameras.isEmpty) {
      return;
    }

    _initializeController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(17, 22, 39, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(17, 22, 39, 1),
        title: const Text(
          'Вдохновение',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            backgroundColor: Colors.transparent,
          ),
        ),
        actions: <Widget>[
          Ink(
            width: 28,
            height: 28,
            decoration: const ShapeDecoration(
              color: Color.fromRGBO(41, 45, 61, 1),
              shape: CircleBorder(),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 22,
              icon: const Icon(Icons.close),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(width: 10,height: 10,)
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: CameraPreview(_controller)
          ),
          Row(
            verticalDirection: VerticalDirection.up,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: _changeCamera, 
                color: Colors.white,
                icon: const Icon(Icons.autorenew),
                style: const ButtonStyle(iconSize: WidgetStatePropertyAll(40)),
                ),
              IconButton(
                onPressed: () { _takePicture(context); },
                color: Colors.white,
                icon: const Icon(Icons.brightness_1_outlined),
                style: const ButtonStyle(iconSize: WidgetStatePropertyAll(80)),
              ),
              IconButton(
                onPressed: flashToggle,
                icon: _flashMode == FlashMode.off ? const Icon(Icons.bolt) : const Icon(Icons.offline_bolt),
                color: Colors.white,
                style: const ButtonStyle(iconSize: WidgetStatePropertyAll(40),
                )
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _initializeController() async {
    _controller = CameraController(
        widget.cameras[_selectedCameraIndex],
        ResolutionPreset.max,
    );

    await _controller.initialize();

    if (mounted) setState(() {});
  }

  Future<void> _changeCamera() async {
    if(widget.cameras.length < 2) {
      return;
    }

    _selectedCameraIndex = (++_selectedCameraIndex) % widget.cameras.length;

    _controller.setDescription(widget.cameras[_selectedCameraIndex]);

    if (mounted) setState(() {});
  }

  Future<void> _takePicture(BuildContext context) async {
    File image = File((await _controller.takePicture()).path);

    if(!context.mounted) return;

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => PreviewScreen(image: image))
    );

    if ((result != true) || !context.mounted) return;

    Navigator.of(context).pop(image);
  }

  Future<void> flashToggle() async {
    _flashMode == FlashMode.off ? _flashMode = FlashMode.always : _flashMode = FlashMode.off;

    await _controller.setFlashMode(_flashMode);
    setState(() {});
  }
}