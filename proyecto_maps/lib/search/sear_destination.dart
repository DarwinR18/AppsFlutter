import 'package:flutter/material.dart';

import '../models/search_result.dart';

class SearDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel; 

  SearDestination():this.searchFieldLabel = 'Buscar';

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
     return const Text('dabuildResultsta');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Colocar Ubicación Manualmente'),
          onTap: (){
            this.close(context, SearchResult(cancelo: false, manual: true));
          }
        )
      ]
    );
  }

}