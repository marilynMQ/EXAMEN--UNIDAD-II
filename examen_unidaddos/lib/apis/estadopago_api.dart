


import 'package:dio/dio.dart';
import 'package:examen_unidaddos/modelo/estadopagoModelo.dart';
import 'package:examen_unidaddos/util/UrlApi.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

part 'estadopago_api.g.dart';
@RestApi(baseUrl: UrlApi.urlApix)
abstract class EstadopagoApi {
  factory EstadopagoApi(Dio dio, {String baseUrl}) = _EstadopagoApi;

  static EstadopagoApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return EstadopagoApi(dio);
  }

  @POST("/estadospago")
  Future<EstadopagoModelo> creaEstadopago(@Body() EstadopagoModelo user);

  @GET("/estadospago/{id}")
  Future<EstadopagoModelo> getEstadopago(@Path() int id);

  @PUT("/estadospago/{id}")
  Future<EstadopagoModelo> updateEstadopago(@Path() int id, @Body() EstadopagoModelo user);

  @DELETE("/estadospago/{id}")
  Future<void> deleteEstadopago(@Path() int id);

  @GET("/estadospago")
  Future<List<EstadopagoModelo>> listEstadospago();

}