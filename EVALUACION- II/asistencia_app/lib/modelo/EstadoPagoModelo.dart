
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
@Entity(tableName: "estadopago")
class EstadoPagoModelo {

  @primaryKey
  late  int id=0;
  @ColumnInfo(name: "nombre")
  late final String nombre;
  @ColumnInfo(name: "descripcion")
  late final String descripcion;
  
  @ignore
  late List<EstadoPagoxRModelo> estadopagoxs=[];

  EstadoPagoModelo({
    required this.id,
    required this.nombre,
    required this.descripcion,
    
  });

  EstadoPagoModelo.unlaunched();



  EstadoPagoModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    
    if (json['estadopagoxs'] != null) {
      estadopagoxs = (json['estadopagoxs'] as List).map((e) =>
          EstadoPagoxRModelo.fromJson(e as Map<String, dynamic>)).toList();
    }else{ estadopagoxs=[]; }
  }

  factory EstadoPagoModelo.fromJsonModelo(Map<String, dynamic> json){
   return EstadoPagoModelo(
       id : json['id'],
       nombre : json['nombre'],
       descripcion : json['descripcion']
   );
  }

  EstadoPagoModelo.fromJsonLocal(Map<String,
      dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['descripcion'] = descripcion;
    if (this.estadopagoxs != null) {
      _data['estadopagoxs'] = this.estadopagoxs.map((v) => v.toJson()).toList();
    }
    return _data;
  }
}

class EstadoPagoxRModelo {
  late int id=0;
  late final String nombre;
  late final String descripcion;
  

  EstadoPagoxRModelo({
    required this.id,
    required this.nombre,
    required this.descripcion,
    
  });

  factory EstadoPagoxRModelo.fromJson(Map<String, dynamic> json){
    return EstadoPagoxRModelo(
      id: json["id"],
      nombre:json["nombre"],
      descripcion: json["descripcion"],
      
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    //final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['descripcion'] = this.descripcion;
  
    return data;
  }


}