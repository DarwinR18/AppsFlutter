part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({ Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if(state.seleccionManual){
          return Container();
        }else{
          return FadeInDown(
            duration: Duration(milliseconds:300),
            child: buildSearchBar(context));
        }
      },
    );
  }

  @override
  Widget buildSearchBar(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector (
        onTap: ()async{
          final resultado= await showSearch(context: context, delegate: SearDestination());
          retornoBusqueda(context,resultado);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal:30),
          width: width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical:13),
            width: double.infinity,
            child: const Text('¿Dónde te gustaría ir?', style:TextStyle(color: Colors.black87)),
            decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0,5),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  void retornoBusqueda(BuildContext context, SearchResult result){
    print('cancelo: ${result.cancelo}');
    print('manual: ${result.manual}');
    if(result.cancelo) return;

    if(result.manual){
      context.read<BusquedaBloc>().add(OnActivarMarcadorManual());
      return ;
    }
  }

  
}