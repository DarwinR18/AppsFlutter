//Pagína de mapas
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/mapa/mapa_bloc.dart';
import '../bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import '../widgets/widgets.dart';

class MapaPage  extends StatefulWidget {
 
  const MapaPage ({ Key? key }) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    context.read<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
        builder: (_, state) => crearMapa(state)
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
        ],
      )
    );
  }

  Widget crearMapa(MiUbicacionState state){
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    if(!state.existeUbicacion) return const Text('Ubicando ...');
    final cameraPosition = CameraPosition(
      target: state.ubicacion,
      zoom:15
    );
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapType: null,
      onMapCreated: mapaBloc.initMapa,
    );
  }


}
