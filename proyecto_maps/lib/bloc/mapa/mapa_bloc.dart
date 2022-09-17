import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../themes/uber_map_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(new MapaState());
  GoogleMapController ?_mapaController;  

  void initMapa(GoogleMapController controller) {
    if(!state.mapaListo){
      _mapaController = controller;
      _mapaController!.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapaListo());
    }
    
  }

  void moverCamara(LatLng destino){
    final cameraUpdate= CameraUpdate.newLatLng(destino);
    _mapaController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async *{
    if(event is OnMapaListo){
      yield state.copyWith(mapaListo:true);
    }
  }
}
