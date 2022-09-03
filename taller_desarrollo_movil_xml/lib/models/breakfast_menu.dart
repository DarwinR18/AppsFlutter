import 'dart:core';

class Food{
  String _name;
  String _price;
  String _description;
  int _calories;
  String _imagen;

  Food(this._name, this._price, this._description, this._calories, this._imagen);

  static Food?fromJson(Map<String,dynamic> json) {
    if(json == null){
      return null;
    }else{
      return Food(json['name'], json['price'], json['description'], json['calories'], json['imagen']);
    }

    
  }
  get name => this._name;
  get price => this._price;
  get description => this._description;
  get calories => this._calories;
  get imagen => this._imagen;
}


