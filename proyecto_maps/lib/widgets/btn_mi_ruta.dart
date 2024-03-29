part of 'widgets.dart';


class BtnMiRuta extends StatelessWidget {
  const BtnMiRuta({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc=context.read<MapaBloc>();
    

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child:CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.more_horiz, color: Colors.black87),
          onPressed: () {  
            mapaBloc.add(OnMarcarRecorrido());
          },
        ),
      )
      
    );
  }
} 