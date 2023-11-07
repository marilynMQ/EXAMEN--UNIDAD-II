
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EstadopagoModelo {
  EstadopagoModelo({
    required this.idEstadop,
    required this.nombre,
    required this.descripcion,
  });
  late final int idEstadop;
  late final String nombre;
  late final String descripcion;

  factory EstadopagoModelo.fromJson(Map<String, dynamic> json){
    return EstadopagoModelo(
        idEstadop : json['id_estadop'],
        nombre : json['nombre'],
        descripcion : json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_estadop'] = idEstadop;
    _data['nombre'] = nombre;
    _data['descripcion'] = descripcion;
    return _data;
  }
}