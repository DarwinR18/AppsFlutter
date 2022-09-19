import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../mapa/mapa_bloc.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState()) {
    
  }

  @override
  Stream<BusquedaState> mapEventToState(BusquedaEvent event) async* {
    if(event is OnActivarMarcadorManual){
      yield state.copyWith(seleccionManual: true);
    }else{
      yield state.copyWith(seleccionManual: false);
    }
    
  }
}