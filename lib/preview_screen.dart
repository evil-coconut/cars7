import 'dart:io';

import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.image});

  final File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(17, 22, 39, 1),
      ),
      backgroundColor: const Color.fromRGBO(17, 22, 39, 1),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: Image.file(image, fit: BoxFit.cover,)
          ),
          const SizedBox(width: 20, height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pop(context, false);
                }, 
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  ),
                  style: const ButtonStyle(iconSize: WidgetStatePropertyAll(50)),
              ),
              IconButton(
                onPressed: (){
                  Navigator.pop(context, true);
                }, 
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                style: const ButtonStyle(iconSize: WidgetStatePropertyAll(50)),
              ),
            ],
          )
        ],
      ),
    );
  }
}