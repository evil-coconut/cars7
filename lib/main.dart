//import 'package:cars7/main_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    Container(
      color: Colors.white,
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(fontFamily: 'OpenSans'),
      debugShowCheckedModeBanner: false,
      //home: const MainScreen(),
    );
  }

}

