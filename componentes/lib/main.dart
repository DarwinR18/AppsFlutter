import 'package:componentes/src/pages/home_temp.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      home: HomePageTemp()
      );
  }
}