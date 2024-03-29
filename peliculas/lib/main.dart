import 'package:flutter/material.dart';

import 'package:peliculas/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consumo de API - Peliculas',
      initialRoute: '/',
      routes: {
        '/':( BuildContext context) => HomePage(),
      },
    );
  }
}