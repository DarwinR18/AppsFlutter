import 'package:flutter/material.dart';
import 'package:taller_desarrollo_movil_xml/desauno_page.dart';
import 'package:taller_desarrollo_movil_xml/home_page.dart';
import 'package:taller_desarrollo_movil_xml/plantas_page.dart';
import 'package:taller_desarrollo_movil_xml/receta_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller Lectura XML',
      initialRoute: '/',
      routes: {
        '/':( BuildContext context) => HomePage(),
        'desayuno': ( BuildContext context) => DesayunoPage(),
        'recetas':( BuildContext context) => RecetaPage(),
        'plantas':( BuildContext context) => PlantasPage(),
      },
        
    );
  }
}