import 'package:flutter/material.dart';
import 'package:taller_desarrollo_movil_xml/models/planta_model.dart';
import 'package:xml/xml.dart' as xml;

class PlantasPage extends StatelessWidget {
  Future<List<Planta>> getFoodFromXML(BuildContext context) async{
    String xmlFood= await DefaultAssetBundle.of(context).loadString('assets/Planta.xml');
    List<Planta> plantas=[];
    var rawFood = xml.parse(xmlFood);
    var element = rawFood.findAllElements("PLANT");
    
    for(var item in element) {
      plantas.add(
        Planta(item.findElements("COMMON").first.text, 
              item.findElements('BOTANICAL').first.text,
              item.findElements('ZONE').first.text,
              item.findElements('LIGHT').first.text,
              item.findElements('PRICE').first.text,
              item.findElements('AVAILABILITY').first.text,
              item.findElements('imagen').first.text,
              
              ));
    }
    print(plantas.length);
    return plantas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogo de Plantas')
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

    List<Widget> plantas =[];
    for(var planta in data){
      print(planta);
      plantas.add(Card(
        child:Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                children: [
                Text("Common: "+planta.common.toString(), style:TextStyle(fontWeight: FontWeight.bold)),
                Text("Botanical: "+planta.botanical.toString()),
                Text("Zone: "+planta.zone.toString()),
                Text("Light: "+planta.light.toString()),
                Text("Price: "+planta.price.toString()),
                Text("availability: "+planta.availability.toString()),
                
              ],
           
      ),
            ),
      Container(
        width: MediaQuery.of(context).size.width*0.4,
        child: Column(
children: [Image(width: 200, height: 200, image:AssetImage("assets/"+planta.imagen.toString())),],
        ),
      )
       
          ],
        )));
      print(plantas.length);
    }
    return plantas;
  }
}