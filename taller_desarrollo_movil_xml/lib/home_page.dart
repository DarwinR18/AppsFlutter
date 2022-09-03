import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taller de Lectura XML'
        )
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*0.4, 
          width: MediaQuery.of(context).size.width*0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.arrow_circle_right),
                onPressed: (){
                  Navigator.pushNamed(context, 'desayuno');
                  print('DESAYUNOS');
                }, 
                label: const Text('Leer Menu de Desayunos'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50)
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.arrow_circle_right),
                onPressed: (){
                  Navigator.pushNamed(context, 'recetas');
                  print('RECETAS');
                }, 
                label:const Text('Leer Recetas'),
                style: ElevatedButton.styleFrom(
                  minimumSize:const Size(150, 50)
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.arrow_circle_right),
                onPressed: (){
                  Navigator.pushNamed(context, 'plantas');
                  print('PLANTAS');
                }, 
                label: const Text('Leer Catálogos de Plantas'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50)
                ),
              )
            ]
            ),
        ),
      ),
    );
  }
}