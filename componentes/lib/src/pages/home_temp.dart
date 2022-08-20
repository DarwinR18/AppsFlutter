// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_collection_literals

import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {

  final opciones=['uno', 'dos', 'tres', 'cuatro', 'cinco'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text('Componentes Temp'),),
      body: ListView(
        children: _crearItemsCorta(),
      ),
    );
  }

  List<Widget> _crearItems(){
    // ignore: deprecated_member_use, unnecessary_new
    List<Widget> lista= [];

    for(var element in opciones){
      final tempWidget = ListTile(
        title: Text(element),
      );
      lista..add(tempWidget)
           ..add(Divider());
    }
    return lista;
  }

  List<Widget> _crearItemsCorta(){
    return opciones.map((e){
      return Column(
        children: [
          ListTile(
            title: Text(e),
            subtitle: Text('data'),
            leading: Icon(Icons.access_alarm_rounded),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){},
          ),
          Divider(color: Colors.blue,),
        ],
      );
    }).toList();
  }
}