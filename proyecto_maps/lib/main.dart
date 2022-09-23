import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_maps/pages/acceso_gps_page.dart';
import 'package:proyecto_maps/pages/loading_page.dart';
import 'package:proyecto_maps/pages/mapa_page.dart';

import 'bloc/busqueda/busqueda_bloc.dart';
import 'bloc/mapa/mapa_bloc.dart';
import 'bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'bloc/provider.dart';
import 'pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MiUbicacionBloc()),
          BlocProvider(create: (_) => MapaBloc()),
          BlocProvider(create: (_) => BusquedaBloc()),
        ],
        child: MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          home:  LoginPage(),
          routes: {
            'login': (_)=> LoginPage(),
            'mapa':(_)=> const MapaPage(),
            'loading': (_)=> const LoadingPage(),
            'acceso_gps': (_)=> const AccesoGpsPage(),
          },
        ),
      ),
    );
  }
}