class Recetas {
  String _tipo;
  String _dificultad;
  String _nombre;
  String _imagen;
  String _ingredientes;
  String _calorias;
  String _pasos;
  String _tiempo;
  String _elaboracion;

  Recetas(this._tipo, this._dificultad, this._nombre, this._imagen, this._ingredientes, this._calorias, this._pasos, this._tiempo, this._elaboracion);

   static Recetas?fromJson(Map<String,dynamic> json) {
    if(json == null){
      return null;
    }else{
      return Recetas(json['tipo'], json['dificultad'], json['nombre'], json['imagen'], json['ingredientes'], json['calorias'], json['pasos'], json['tiempo'], json['elaboracion']);
    }
  }
  get tipo=>this._tipo;
  get dificultad=>this._dificultad;
  get nombre=>this._nombre;
  get imagen=>this._imagen;
  get calorias=>this._calorias;
  get pasos=>this._pasos;
  get tiempo=>this._tiempo;
  get elaboracion=>this._elaboracion;
  get ingredientes => this._ingredientes;
}