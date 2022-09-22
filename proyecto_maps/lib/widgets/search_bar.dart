part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({ Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if(state.seleccionManual){
          return Container();
        }else{
          return FadeInDown(
            duration: Duration(milliseconds:300),
            child: buildSearchBar(context));
        }
      },
    );
  }

  @override
  Widget buildSearchBar(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector (
        onTap: ()async{
          final proximidad = context.read<MiUbicacionBloc>().state.ubicacion;
          final historial = context.read<BusquedaBloc>().state.historial;

          final resultado= await showSearch(
            context: context,
            delegate: SearDestination(proximidad, historial),
          );

          retornoBusqueda(context,resultado);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal:30),
          width: width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical:13),
            width: double.infinity,
            child: const Text('Hoy a dónde iré ...', style:TextStyle(color: Colors.black87)),
            decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0,5),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  void retornoBusqueda(BuildContext context, SearchResult result) async{
    print('cancelo: ${result.cancelo}');
    print('manual: ${result.manual}');
    if(result.cancelo) return;

    if(result.manual){
      context.read<BusquedaBloc>().add(OnActivarMarcadorManual());
      return ;
    }
    calculandoAlerta(context);
    //calcula la ruta de busqueda
    final trafficService= TrafficService();
    final mapaBloc=context.read<MapaBloc>();
    final inicio= context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = result.position;

    final drivingResponse = await trafficService.getCoordsInicioYDestino(inicio, destino);

    final geometry= drivingResponse.routes[0].geometry;
    final duration= drivingResponse.routes[0].duration;
    final distance= drivingResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);

    final List<LatLng> rutaCordenadas= points.decodedCoords.map(
      (point) => LatLng( point[0], point[1])
    ).toList();

    mapaBloc.add(OnCrearRutaInicioDestino(rutaCordenadas, distance,duration));

    Navigator.of(context).pop();

    // se agrega la busqueda al newHistorial
    final busquedaBloc = context.read<BusquedaBloc>();
    busquedaBloc.add(OnAgregarHistorial(result));
  }

  
}