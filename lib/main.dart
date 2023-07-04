import 'package:flutter/material.dart';
import 'package:xoxo/XOXOGameScreen.dart';
import 'package:xoxo/splash.dart';

void main() {
  runApp(XOXOGame());
}

class XOXOGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XOXO Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner:false,
    );
  }
}