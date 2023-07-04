import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xoxo/XOXOGameScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {  
    super.initState();  
    Timer(Duration(seconds: 3),  
            ()=>Navigator.pushReplacement(context,  
            MaterialPageRoute(builder:  
                (context) => XOXOGameScreen()  
            )  
         )  
    );  
  }  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("images/XOXO.jpeg"),
      ),
    );
  }
}