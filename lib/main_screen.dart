import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cars7/camera_screen.dart';
import 'package:cars7/promotional_code.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<CameraDescription> _cameras = [];
  Image _image = Image.asset('assets/images/placeholder.png', width: 335, height: 335, fit: BoxFit.cover);

  bool _showPromocode = false;


  @override
  void initState() {
    super.initState();
    getCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Творчество',
        style: TextStyle(
            color: Color.fromRGBO(49, 64, 120, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          Ink(
            width: 28,
            height: 28,
            decoration: const ShapeDecoration(
              color: Color.fromRGBO(243, 243, 243, 1),
              shape: CircleBorder(),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 22,
              icon: const Icon(Icons.close),
              color: const Color.fromRGBO(147, 150, 156, 1),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 10,height: 10,)
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children:[ 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child:_image
                    ),
                    if (_showPromocode) const PromotionalCode(),
                  ]
                ),
                const SizedBox(width: 20, height: 20,),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: const WidgetStatePropertyAll(Color.fromRGBO(82, 87, 99, 1)),
                    backgroundColor: const WidgetStatePropertyAll(Color.fromRGBO(243, 243, 243, 1)),
                    padding: const WidgetStatePropertyAll(EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 20)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )
                    )
                  ),
                  onPressed: openCamera,
                  child: const Text("Поменять картинку"),
                ),
              ]
            ),
            Column(
              children: [
                Container(
                  width: 335,
                  height: 88,
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: Color.fromRGBO(147, 150, 156, 1),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'Дополнительная информация',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 6,),
                      Text(
                        'Промокод можно передвинуть куда пожелаете и поделиться своим творением.',
                        style: TextStyle(
                          color: Color.fromRGBO(82, 87, 99, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 11
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                FilledButton(
                  style: ButtonStyle(
                    fixedSize: const WidgetStatePropertyAll(Size(335, 70)),
                    foregroundColor: const WidgetStatePropertyAll(Colors.white),
                    backgroundColor: const WidgetStatePropertyAll(Colors.black),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      )
                    )
                  ),
                  onPressed: (){}, 
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 15,),
                      Text('Поделиться творением',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 30,)
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> getCameras() async { _cameras = await availableCameras(); }

  Future<void> openCamera() async {
    if(_cameras.isEmpty) return;

    final result = await Navigator.push<File>(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen(cameras: _cameras))
    );
    
    if(result != null) {
      _image = Image.file(result, width: 335, height: 335, fit: BoxFit.cover);
      _showPromocode = true;
      setState(() {});
    }
  }
}