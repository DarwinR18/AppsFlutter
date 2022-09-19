import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../themes/uber_map_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(new MapaState());
  //color por defecto de la polyline
  Polyline _miRuta = Polyline(
    polylineId: PolylineId('mi_ruta'),
    width: 4,
    color: Colors.transparent
  );
  Polyline _miRutaDestino = Polyline(
    polylineId: PolylineId('mi_ruta_destino'),
    width: 4,
    color: Colors.black87
  );
  GoogleMapController _mapaController;  
//Da a lugar al inicio de la muestra del mapa
  void initMapa(GoogleMapController controller) {
    if(!state.mapaListo){
      _mapaController = controller;
      _mapaController.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapaListo());
    }
    
  }
// calcula el cambio del posicionamiento o camara
  void moverCamara(LatLng destino){
    final cameraUpdate= CameraUpdate.newLatLng(destino);
    _mapaController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async *{
    if(event is OnMapaListo){
      yield state.copyWith(mapaListo:true);
    }else if (event is OnNuevaUbicacion){
      yield* _onNuevaUbicacion(event);

    }else if (event is OnMarcarRecorrido){
      yield* _onMarcarRecorrido(event);

    }else if (event is OnSeguirUbicacion){
     yield* _onSeguirUbicacion(event);

    }else if (event is OnMovioMapa){
      //recoge lat y long del movimiento del mapa
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    }else if(event is OnCrearRutaInicioDestino){
      yield* _onCrearRutaInicioDestino(event);
    }
  }
//se trata de la definición de la Ubi. inicial hacía la final y cuando hay algun cambio
  Stream<MapaState> _onNuevaUbicacion(OnNuevaUbicacion event) async*{
    if(state.seguirUbicacion){
      moverCamara(event.ubicacion);
    }
    print('NUEVA UBICACION ${event.ubicacion}');
      List<LatLng> points = [..._miRuta.points , event.ubicacion];
      this._miRuta = this._miRuta.copyWith(pointsParam:points);
      final currentPolyline = state.polylines;
      currentPolyline['mi_ruta']= this._miRuta;

      yield state.copyWith(polylines:currentPolyline);
  }
//Elimina o muestra el recorrido que se ha llevado
  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async*{
    if(!state.dibujarRecorrido){
        this._miRuta=this._miRuta.copyWith(colorParam: Colors.black87);
      }else{
        this._miRuta=this._miRuta.copyWith(colorParam: Colors.transparent);
      }

      final currentPolyline = state.polylines;
      currentPolyline['mi_ruta']= this._miRuta;
      yield state.copyWith(
        dibujarRecorrido: !state.dibujarRecorrido,
        polylines:currentPolyline,
      );
  }
// Sigue la ubicación del puntero
  Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion) async*{
     if(!state.seguirUbicacion){
        moverCamara(_miRuta.points[_miRuta.points.length - 1]);
      }
      yield state.copyWith(seguirUbicacion: !state.seguirUbicacion); 
  }

  Stream<MapaState> _onCrearRutaInicioDestino(OnCrearRutaInicioDestino event) async*{
    _miRutaDestino= _miRutaDestino.copyWith(
      pointsParam: event.rutaCordenadas
    );

    final currentPolyline = state.polylines;
    currentPolyline['mi_ruta_destino']= _miRutaDestino;
    yield state.copyWith(
      polylines:currentPolyline,
      
    );
  }
}
