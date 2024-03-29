part of 'widgets.dart';


class BtnUbicacion extends StatelessWidget {
  const BtnUbicacion({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc=context.read<MapaBloc>();
    final miUbicacion=context.read<MiUbicacionBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child:CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black87),
          onPressed: () {  
            final destino= miUbicacion.state.ubicacion;
            mapaBloc.moverCamara(destino);
          },
        ),
      )
      
    );
  }
} 