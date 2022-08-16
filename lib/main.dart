
import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ValueNotifier and ValueListenableBuilder Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const Home(),
    );
  }
}