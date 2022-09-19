import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsPage extends StatefulWidget {
 
  const AccesoGpsPage({ Key key }) : super(key: key);

  @override
  State<AccesoGpsPage> createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage>  with WidgetsBindingObserver{

  //Estamos pendientes de los estados de la app con estos 3 métodos - inicializa - elimina y escucha
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    // TODO: implement didChangeAppLifecycleState
    print('================> $state');
    if(state == AppLifecycleState.resumed){
      if(await Permission.location.isGranted){
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Es necesario tener activado el GPS'),
            MaterialButton(
              child: const Text('Solicitar Acceso', style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: const StadiumBorder(), 
              elevation:0,
              splashColor: Colors.transparent,
              onPressed: () async {
                final status = await Permission.location.request();

                accesoGPS(status, context);
                
                },
            )
          ],
        )
      )
    );
  }

  void accesoGPS(PermissionStatus status, BuildContext context) {
   switch (status) {
     case PermissionStatus.granted: Navigator.pushReplacementNamed(context, 'mapa');
     break;
     case PermissionStatus.denied:
     case PermissionStatus.undetermined:
     case PermissionStatus.restricted:
     case PermissionStatus.permanentlyDenied: 
     case PermissionStatus.limited:
      openAppSettings();
       // TODO: Handle this case.
       break;
   }
  }
}