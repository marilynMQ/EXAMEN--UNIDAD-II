
import 'dart:io';

import 'package:asistencia_app/modelo/EstadoPagoModelo.dart';
import 'package:asistencia_app/modelo/GenericModelo.dart';
import 'package:asistencia_app/util/UrlApi.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

part 'estadopago_api.g.dart';
@RestApi(baseUrl: UrlApi.urlApix)
abstract class EstadoPagoAPi {
  factory EstadoPagoAPi(Dio dio, {String baseUrl}) = _EstadoPagoAPi;

  static EstadoPagoAPi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return EstadoPagoAPi(dio);
  }

  @GET("/asis/estadopago/list")
  Future<List<EstadoPagoModelo>> getEstadoPago(@Header("Authorization") String token);

  @POST("/asis/estadopago/crear")
  Future<EstadoPagoModelo> crearEstadoPago(@Header("Authorization") String token, @Body() EstadoPagoModelo estadopago);

  @GET("/asis/estadopago/buscar/{id}")
  Future<EstadoPagoModelo> findEstadoPago(@Header("Authorization") String token, @Path("id") int id);

  @DELETE("/asis/estadopago/eliminar/{id}")
  Future<GenericModelo> deleteEstadoPago(@Header("Authorization") String token, @Path("id") int id);

  @PUT("/asis/estadopago/editar/{id}")
  Future<EstadoPagoModelo> updateEstadoPago(@Header("Authorization") String token, @Path("id") int id , @Body() EstadoPagoModelo estadopago);
}