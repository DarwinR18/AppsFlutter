// ignore_for_file: use_key_in_widget_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

   List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize=MediaQuery.of(context).size;
    return Container(
    padding: const EdgeInsets.only(top: 10.0),
    
    child: Swiper(
      layout: SwiperLayout.STACK,
      itemWidth: _screenSize.width * 0.6,
      itemHeight: _screenSize.height * 0.5,
      itemBuilder: (BuildContext context, int index){
        
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            image: NetworkImage(
              peliculas[index].getPosterImg() , 
              ),
              placeholder: const AssetImage('lib/assets/img/no-image.jpg'),
              fit: BoxFit.cover,
          ),
        );
      },
       itemCount: peliculas.length,
    ),
  );
  }
}