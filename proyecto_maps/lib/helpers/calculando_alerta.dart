part of 'helpers.dart';

void calculandoAlerta(BuildContext context){
  showDialog(
    context: context,
    builder: (context)=> const AlertDialog(
      title:Text('Espere un momento'),
      content: Text('Calculando ruta ...'),
    )
  );
}