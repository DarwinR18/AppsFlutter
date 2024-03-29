import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polyline/polyline.dart' as Poly;
import 'package:proyecto_maps/helpers/helpers.dart';

import '../bloc/busqueda/busqueda_bloc.dart';
import '../bloc/mapa/mapa_bloc.dart';
import '../bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../models/search_result.dart';
import '../search/sear_destination.dart';
import '../services/trafic_service.dart';


part 'btn_ubicacion.dart';
part 'btn_mi_ruta.dart';
part 'btn_seguir_ubicacion.dart';
part 'search_bar.dart';
part 'marcador_manual.dart';