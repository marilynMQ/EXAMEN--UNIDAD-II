import 'dart:async';
import 'package:asistencia_app/apis/estadopago_api.dart';
import 'package:asistencia_app/local/dao/ActividadDao.dart';
import 'package:asistencia_app/local/dao/EstadoPago.dart';
import 'package:asistencia_app/modelo/ActividadModelo.dart';
import 'package:asistencia_app/modelo/EstadoPagoModelo.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart'; // the generated code will be there
//https://github.com/pinchbv/floor
//flutter packages pub run build_runner build
//flutter packages pub run build_runner watch
@Database(version: 2, entities: [ActividadModelo])
@Database(version: 2, entities: [EstadoPagoModelo])

abstract class AppDatabase extends FloorDatabase {
  ActividadDao get actividadDao;
  EstadoPagoDao get estadopagoDao;

}