import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../helpers/helpers.dart';
import 'acceso_gps_page.dart';
import 'mapa_page.dart';

class LoadingPage extends StatefulWidget {

  const LoadingPage ({ Key? key }) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver{

   @override
   void initState() {
    WidgetsBinding.instance!.addObserver(this);
     super.initState();
     
   }
  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state)async {
    if(state == AppLifecycleState.resumed){
      if(await Geolocator().isLocationServiceEnabled()){
         Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: chechGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if( snapshot.hasData){
            return Center(child: Text(snapshot.data),);
          }else{
            return const Center(
            child: CircularProgressIndicator(strokeWidth: 3,),
          );
          }
        }
      )
    );
  }

  Future chechGpsYLocation(BuildContext context) async {
    //ToDo: Permiso GPS y si tiene GPS Activo
    final permisoGPS = await Permission.location.isGranted;

    final gpsActive = await Geolocator().isLocationServiceEnabled();
    
    if( permisoGPS && gpsActive){
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      return '';
    } else if( !permisoGPS){
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoGpsPage()));
      return 'Es necesario el permiso de GPS';
    }else{
      return ' Active el GPS';
    }
  }
}