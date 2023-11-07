

import 'package:asistencia_app/modelo/EstadoPagoModelo.dart';
import 'package:floor/floor.dart';
@dao
abstract class EstadoPagoDao {
  @Query('SELECT * FROM EstadoPago')
  Future<List<EstadoPagoModelo>> findAllEstadoPago();

  @Query('SELECT nombre FROM EstadoPago')
  Stream<List<String>> findAllEstadoPagoName();

  @Query('SELECT * FROM EstadoPago WHERE id = :id')
  Stream<EstadoPagoModelo?> findEstadoPagoById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEstadoPago(EstadoPagoModelo estadopago);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllEstadoPago(List<EstadoPagoModelo> todo);

  @update
  Future<void> updateEstadoPago(EstadoPagoModelo estadopago);

  @Query("delete from EstadoPago where id = :id")
  Future<void> deleteEstadoPago(int id);

  @delete
  Future<void> deleteAll(List<EstadoPagoModelo> list);
}