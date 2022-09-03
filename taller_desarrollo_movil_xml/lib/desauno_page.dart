import 'package:flutter/material.dart';
import 'package:taller_desarrollo_movil_xml/models/breakfast_menu.dart';
import 'package:xml/xml.dart' as xml;

class DesayunoPage extends StatelessWidget {
  Future<List<Food>> getFoodFromXML(BuildContext context) async{
    String xmlFood= await DefaultAssetBundle.of(context).loadString('assets/comida.xml');
    List<Food> foods=[];
    var rawFood = xml.parse(xmlFood);
    var element = rawFood.findAllElements("food");
    
    for(var item in element) {
      print(item.findElements('name').first.text);
      foods.add(
        Food(item.findElements("name").first.text, 
              item.findElements('price').first.text,
              item.findElements('description').first.text,
              int.parse(item.findElements('calories').first.text),
              item.findElements('imagen').first.text,
              ));
    }
    print(foods.length);
    return foods;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu de Desayunos')
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

    List<Widget> foods =[];
    for(var food in data){
      print(food);
      foods.add(Card(
        child:Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                children: [
                Text("Nombre: "+food.name.toString(), style:TextStyle(fontWeight: FontWeight.bold)),
                Text("Precio: "+food.price.toString()),
                Text("Descripcion: "+food.description.toString()),
                Text("Caloria: "+food.calories.toString()),
                
              ],
           
      ),
            ),
      Container(
        width: MediaQuery.of(context).size.width*0.4,
        child: Column(
children: [Image(width: 200, height: 200, image:AssetImage("assets/"+food.imagen.toString())),],
        ),
      )
       
          ],
        )));
      print(foods.length);
    }
    return foods;
  }
}