
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    final TextStyle estiloTexto = new TextStyle( fontSize: 25);
    final int contador=10;

    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Números de Clicks: ", style: estiloTexto),
            Text('$contador', style: estiloTexto ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("Hola Mundo");

        },
      ),
    );
  }
}