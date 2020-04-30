import 'package:flutter/material.dart';
class ContadorPage extends StatefulWidget{
  @override
  createState()=>_ContadorPaginaEstado(); 
}

class _ContadorPaginaEstado extends State <ContadorPage>{
  int _contador=0;
  @override
  Widget build(BuildContext context) {
    final TextStyle _estiloTexto = new TextStyle( fontSize: 25, color: Color.alphaBlend(Colors.blueGrey, Colors.transparent) );
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador de Taps'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Números de taps: ", style: _estiloTexto),
            Text('$_contador', style: _estiloTexto ),
          ],
        ),
      ),
      floatingActionButton: _crearBotones()
      
    );
  }
  
   Widget _crearBotones(){
    return Row(
      mainAxisAlignment:MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 30),
        FloatingActionButton(child: Icon(Icons.exposure_zero), onPressed: _reset),
        Expanded(child: SizedBox(width: 5.0)),
        FloatingActionButton(child: Icon(Icons.remove), onPressed: _sustraer),
        Expanded(child: SizedBox(width: 5.0)),
        FloatingActionButton(child: Icon(Icons.add), onPressed: _agregar),
      ],
    );
  }
    void _agregar() {
      setState(() {
       _contador++;
      });
    }
    void _sustraer(){
      setState(() {
        _contador--;
      });
    }
    void _reset(){
      setState(() {
        _contador=0;
      });
    }
}