
import 'package:flutter/material.dart';

@immutable
class EstadoPagoModeloFire {
  late  String id="";
  late final String nombre;
  late final String descripcion;
  


  EstadoPagoModeloFire({
    required this.id,
    required this.nombre,
    required this.descripcion,
  
  });

  EstadoPagoModeloFire.unlaunched();

  EstadoPagoModeloFire.fromJson(Map<String, dynamic> json){
    id = json['id']==null?"":json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    
  }

  factory EstadoPagoModeloFire.fromJsonModelo(Map<String, dynamic> json){
    return EstadoPagoModeloFire(
        id : json['id']==null?"":json['id'],
        nombre : json['nombre'],
        descripcion : json['descripcion'],
        
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['descripcion'] = descripcion;
    

    return _data;
  }

  Map<String, dynamic> toMap(){
    var data=Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['descripcion'] = this.descripcion;
    
    return data;
  }
}