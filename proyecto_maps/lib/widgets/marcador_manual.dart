part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  const MarcadorManual({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<BusquedaBloc, BusquedaState>(
    builder: (context, state) {
      if(state.seleccionManual){
        return _BuildMarcadorManual();
      }
      else{
        return Container();
      }
    },
   );
  }

}

class _BuildMarcadorManual extends StatelessWidget {
  const _BuildMarcadorManual({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return Stack(
      children: [

        // Regresar
        Positioned(
          top:70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds:150),
            child: CircleAvatar(
              maxRadius:25,
              backgroundColor:Colors.white,
              child:IconButton(
                icon: const Icon(Icons.arrow_back,color:Colors.black87),
                onPressed: (){
          
                  context.read<BusquedaBloc>().add(OnDesactivarMarcadorManual());
          
                }
              )
            ),
          ),

        ),

        //Marcador icono
        Center(
          child:Transform.translate(
            offset:const Offset(0, -12),
            child: BounceInDown(
              from: 200,
              child: const Icon(Icons.location_on, size:50, color:Colors.black54)),),
        ),

        //COnfirma destino
        Positioned(
          bottom:60,
          left: 40,

          child: FadeIn(
            child: MaterialButton(
              minWidth: width-130,
              child:Text('Confirmar Destino', 
                      style: TextStyle(color:Colors.white)
                    ),
              color: Colors.black,
              shape:StadiumBorder(),
              splashColor: Colors.transparent,
              onPressed: (){
                calcularDestino(context);
              }
            ),
          ),
        )
      ]
    );
  }

  void calcularDestino(BuildContext context)async{
    final trafficService = TrafficService();
    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = context.read<MapaBloc>().state.ubicacionCentral;
    final trafficResponse=await trafficService.getCoordsInicioYDestino(inicio, destino);
    // se decodifica los puntos del geometry
    final geometry= trafficResponse.routes[0].geometry;
    final duration= trafficResponse.routes[0].duration;
    final distance= trafficResponse.routes[0].distance;
    final points =Poly.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
    final List<LatLng> rutaCords = points.map(
      (point) => LatLng(point[0], point[1])
    ).toList();
    context.read<MapaBloc>().add(OnCrearRutaInicioDestino(rutaCords,distance, duration));
  }
}