// ignore_for_file: import_of_legacy_library_into_null_safe, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Peliculas en cines"),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [_tarjetas(), 
                const SizedBox(height: 5.0),
                _pieDePantalla(context)]),
          ),
        ));
  }

  Widget _tarjetas() {
    return FutureBuilder(
        future: peliculasProvider.getEnCines(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(
              peliculas: snapshot.data,
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget _pieDePantalla(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          padding: const EdgeInsets.only(left:10.0),
          child: const Text(
            "Populares", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10,),
        FutureBuilder(
            future: peliculasProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(peliculas: snapshot.data);
              } else {
                return const CircularProgressIndicator();
              }
            })
      ]),
    );
  }
}
