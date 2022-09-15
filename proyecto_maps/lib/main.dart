import 'package:flutter/material.dart';
import 'package:proyecto_maps/pages/acceso_gps_page.dart';
import 'package:proyecto_maps/pages/loading_page.dart';
import 'package:proyecto_maps/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: const LoadingPage(),
      routes: {
        'mapa':(_)=> const MapaPage(),
        'loading': (_)=> const LoadingPage(),
        'acceso_gps': (_)=> const AccesoGpsPage(),
      },
    );
  }
}