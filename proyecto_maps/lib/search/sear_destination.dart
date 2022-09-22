import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/search_response.dart';
import '../models/search_result.dart';
import '../services/trafic_service.dart';

class SearDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel; 
  final TrafficService _trafficService;
  final LatLng proximidad;
  List<SearchResult> historial;

  SearDestination(this.proximidad, this.historial)
    :this.searchFieldLabel = 'Quiero ir a ...',
     this._trafficService= TrafficService();


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
      onPressed: () => this.query='',
      icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    
     return IconButton(
      onPressed: () =>this.close(context, SearchResult(cancelo: true)),
      icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
  
    _construirResultadosSugerencias();
     return const Text('dabuildResultsta');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(this.query.length == 0){
      return ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Deseo escoger mi destino'),
            onTap: (){
              this.close(context, SearchResult(cancelo: false, manual: true));
            }
          ),

          ...this.historial.map(
            (result) => ListTile(
              leading:Icon(Icons.history),
              title: Text(result.nombreDestino),
              subtitle: Text(result.description),
              onTap: (){
                this.close(context, result);
              },

            )).toList()
        ]
     );
    }

    return this._construirResultadosSugerencias();
    
  }
  Widget _construirResultadosSugerencias(){
    if(this.query == 0){
      return Container();
    }

    this._trafficService.getSugerenciasPorQuery(this.query, this.proximidad);
    return StreamBuilder(
      stream: this._trafficService.sugerenciasStream,
 
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }else{
          final lugares = snapshot.data.features;
          if(lugares.length==0){
            return ListTile(
              title: Text('No hay resultados para $query'),
            );
          }
          return ListView.separated(
            itemCount:lugares.length,
            separatorBuilder: (_, i)=>Divider(), 
            itemBuilder: (_, i){
              final lugar = lugares[i];
              return ListTile(
                leading: Icon(Icons.place),
                title: Text(lugar.textEs),
                subtitle: Text(lugar.placeNameEs),
                onTap: (){
                  // ignore: unnecessary_this
                  this.close(context, SearchResult(
                    cancelo: false, 
                    manual:false,
                    position: LatLng(
                      lugar.center[1],
                      lugar.center[0],
                    ),
                    nombreDestino: lugar.textEs,
                    description: lugar.placeNameEs,
                  ));
                }
              );
            }
          );
        }
       
      },
    );
  }

}