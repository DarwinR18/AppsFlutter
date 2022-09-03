import 'package:flutter/material.dart';
import 'package:taller_desarrollo_movil_xml/models/planta_model.dart';
import 'package:taller_desarrollo_movil_xml/models/recetas_model.dart';
import 'package:xml/xml.dart' as xml;

class RecetaPage extends StatelessWidget {
  Future<List<Recetas>> getFoodFromXML(BuildContext context) async{
    String xmlFood= await DefaultAssetBundle.of(context).loadString('assets/receta.xml');
    List<Recetas> recetas=[];
    var rawFood = xml.parse(xmlFood);
    var element = rawFood.findAllElements("receta");
    
    for(var item in element) {
      recetas.add(
        Recetas(item.findElements("tipo").first.text, 
              item.findElements('dificultad').first.text,
              item.findElements('nombre').first.text,
              item.findElements('imagen').first.text,
              item.findElements('ingredientes').first.text,
              item.findElements('calorias').first.text,
              item.findElements('pasos').first.text,
              item.findElements('tiempo').first.text,
              item.findElements('elaboracion').first.text,
              ));
    }
    print(recetas.length);
    return recetas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas')
      ),
      body: Container(
       
        child: _comida(context)
      
        ),
      );
  }

  Widget _comida(BuildContext context) {
    return FutureBuilder(
    future: getFoodFromXML(context),
    builder: (context,AsyncSnapshot snapshot) {
      if(snapshot.hasData){
        print(snapshot);
        return ListView(
            children: _lista(context,snapshot.data)
        );
      }else{
        return const CircularProgressIndicator();
      }
    }
    );
  }
  List<Widget> _lista(context,data) {

    List<Widget> recetas =[];
    for(var receta in data){
      print(receta);
      recetas.add(Card(
        child:Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                children: [
                Text("Tipo: "+receta.tipo.toString(), style:TextStyle(fontWeight: FontWeight.bold)),
                Text("Dificultad: "+receta.dificultad.toString()),
                Text("Nombre: "+receta.nombre.toString()),
                Text("Ingredientes: "+receta.ingredientes.toString()),
                Text("Calorias: "+receta.calorias.toString()),
                Text("Pasos: "+receta.pasos.toString()),
                Text("Tiempo: "+receta.tiempo.toString()),
                Text("Elaboracion: "+receta.elaboracion.toString()),
                
              ],
           
      ),
            ),
      Container(
        width: MediaQuery.of(context).size.width*0.4,
        child: Column(
children: [Image(width: 200, height: 200, image:AssetImage("assets/"+receta.imagen.toString())),],
        ),
      )
       
          ],
        )));
      print(recetas.length);
    }
    return recetas;
  }
}