import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{
  final String _apiKey='7dbcef43fc9a26b628943a0f93c8fbd3';
  final String _url='api.themoviedb.org';
  final String _language='es-ES';

Future <List<Pelicula>> _procesarRespuesta(Uri url) async {
  final respuesta = await http.get(url);

    if(respuesta.statusCode==200) {
      
        final decodeData = json.decode(respuesta.body);

        final peliculas = Peliculas.fromJsonList(decodeData['results']);

        return peliculas.items;
    }
}
  Future<List<Pelicula>> getEnCines() async {
    final url=Uri.https(_url, '3/movie/now_playing', {
      'api_key':_apiKey,
      'language':_language
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {

    final url=Uri.https(_url, '3/movie/now_playing', {
      'api_key':_apiKey,
      'language':_language
    });

    return await _procesarRespuesta(url);
  }
    
  
}