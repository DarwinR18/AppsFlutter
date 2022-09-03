import 'dart:core';

class Planta{
  String _common;
  String _botanical;
  String _zone;
  String _light;
  String _price;
  String _availability;
  String _imagen;

  Planta(String this._common, String this._botanical, String this._zone, String this._light, String this. _price, String this._availability, String this._imagen);

  static Planta?fromJson(Map<String,dynamic> json) {
    if(json == null){
      return null;
    }else{
      return Planta(json['COMMON'], json['BOTANICAL'], json['ZONE'], json['LIGHT'], json['PRICE'], json['AVAILABILITY'], json['imagen']);
    }

    
  }
  
  get common => this._common;
  get botanical => this._botanical;
  get zone => this._zone;
  get light => this._light;
  get price => this._price;
  get availability => this._availability;
  get imagen => this._imagen;
}


