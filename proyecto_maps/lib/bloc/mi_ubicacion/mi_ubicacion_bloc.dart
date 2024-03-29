
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {

  MiUbicacionBloc() : super(MiUbicacionState());
  //Instancia de geolocator para obtener posiciones
  final _geolocator = Geolocator();

  StreamSubscription<Position> _positionSubscription;

  void iniciarSeguimiento() {
    //acceso a metodos para obtener assertions más proximas y cada 10m obtener positions
    const geolocatorOptions = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    _positionSubscription=_geolocator.getPositionStream(geolocatorOptions).listen((Position position){
      final nuevaUbicacion = LatLng(position.latitude, position.longitude);
      add(OnUbicacionCambio(nuevaUbicacion));
    });
  }

  void cancelarSeguimiento(){
    _positionSubscription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(MiUbicacionEvent event) async* {

    if(event is OnUbicacionCambio){
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.ubicacion
      );
    }

  }
  
}
