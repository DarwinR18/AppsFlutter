// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../bloc/login_bloc.dart';
import '../bloc/provider.dart';
import '../providers/usuario_provider.dart';

class LoginPage extends StatelessWidget {

  final usuarioProvider = UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
       children: [
        _crearFondo(context),
        _loginForm(context),
       ],
      )
    );
  }

Widget _loginForm(BuildContext context) {
  final bloc = Provider.of(context);
  final size= MediaQuery.of(context).size;
  return SingleChildScrollView(
    child:Column(
      children: [
        Container(
          height:size.height*0.30,
        ),
        Container(
          width: size.width*0.85,
          padding:const EdgeInsets.symmetric(vertical: 50.0),
          margin: const EdgeInsets.symmetric(vertical:30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0,5.0),
                spreadRadius: 3.0
              )
            ]
          ),
          child: Column(
            children: [
              const Text('Inicio de Sesión', style: TextStyle(fontSize:20,)),
             const SizedBox(height:50),
              _crearEmail(bloc),
             const SizedBox(height:30),
              _crearPassword(bloc),
             const SizedBox(height:30),
              _crearBoton(bloc, context),
            ],
          )
        ),
        const Text('¿Olvidó la contraseña?'),
        SizedBox(height:100.0),
      ],
    ),
  );
}

 Widget _crearEmail(LoginBloc bloc){
  return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                    hintText: 'Ingrese su correo',
                    labelText: 'Correo Electrónico',
                    counterText: snapshot.data,
                    errorText: snapshot.error
                ),
                    onChanged: (value)=> bloc.changeEmail(value),
              ));
        });
  }

 Widget _crearPassword(LoginBloc bloc){
  return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                  labelText: 'Ingrese Contraseña',
                  counterText: snapshot.data,
                  errorText: snapshot.error
                  ),
                  onChanged: (value)=> bloc.changePassword(value),
            ));
      },
    );
  }

 Widget _crearBoton(LoginBloc bloc, BuildContext context){
  return StreamBuilder(
    stream: bloc.formValidStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
    onPressed: snapshot.hasData ? ()=> _login(bloc, context) :null,

    child:Container(
      padding: const EdgeInsets.symmetric(horizontal:80, vertical:15.0),
      child: const Text('Ingresar'),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    elevation: 0.0,
    color:Colors.deepPurple,
    textColor: Colors.white,
  );
    },
  );
 }

 _login(LoginBloc bloc, BuildContext context) async {
  Map info= await usuarioProvider.login(bloc.email, bloc.password);
  if (info['ok']){
    print('ingreso');
    Navigator.pushReplacementNamed(context, 'loading');
  }else{
    _mostrarAlerta(context, 'Ingrese email o clave correcta');
  }
 }

 void _mostrarAlerta(BuildContext context, String mensaje){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Credenciales Incorrecta'),
        content: Text(mensaje),
        actions: [
          FlatButton(onPressed: ()=>Navigator.of(context).pop(), 
          child: Text('Aceptar')),
        ],
      );
    }
  );
 }

  Widget _crearFondo(BuildContext context) {
    final size= MediaQuery.of(context).size;
    final fondoMorado= Container(
      height: size.height*0.4,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90,70,178,1.0),
          ]
        )
      )
    );
    final circulo = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
    return Stack(
      children: [
        fondoMorado,
        Positioned(
          top:90.0,
          left: 30.0,
          child: circulo
        ),
        Positioned(
          top:-40.0,
          right: -30.0,
          child: circulo
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo
        ),
        Container(
          padding: const EdgeInsets.only(top:80),
          child: Column(
            children:const [
              Icon(Icons.person_pin_circle,
              color:Colors.white, 
              size: 90,),
              SizedBox(height: 10, width: double.infinity),
              Text('My Traces Routes', style: TextStyle(color:Colors.white, fontSize:25.0)),
            ]
          ),
        ),
      ]
    );
  }
}