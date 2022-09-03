// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;

  MovieHorizontal({@required this.peliculas});
  
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height*0.3,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction:0.3,
        ),
        children: _tarjetas(context),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return peliculas.map((pelicula) {
      return Container(
       
        margin: const EdgeInsets.only(right: 15.0, top: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                 height: screenSize.height*0.2,
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: const AssetImage('lib/assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(pelicula.title, overflow: TextOverflow.ellipsis)
          ],
        )
      );
    } ).toList();
  }
}