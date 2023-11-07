import 'package:asistencia_app/apis/estadopago_api.dart';
import 'package:asistencia_app/local/condb/conexiondb.dart';
import 'package:asistencia_app/modelo/EstadoPagoModelo.dart';
import 'package:asistencia_app/modelo/GenericModelo.dart';
import 'package:asistencia_app/util/NetworConnection.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:dio/dio.dart';
class EstadoPagoRepository with ConexionDBL{
  EstadoPagoAPi? estadopagoApi;

  ActividadRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    estadopagoApi = EstadoPagoAPi(_dio);
  }



  Future<List<EstadoPagoModelo>> getEstadoPago() async {
    final estadopagoDao= (await conetion()).estadopagoDao;
    if(await isConected()){
      //return await estadopagoApi!.getActividad(TokenUtil.TOKEN).then((value) => value.data);
      var dato=await estadopagoApi!.getEstadoPago(TokenUtil.TOKEN).then((value) => value);
      dato.forEach((el) async{
        await estadopagoDao.insertEstadoPago(new EstadoPagoModelo(id: el.id,
          nombre: el.nombre, descripcion: el.descripcion,
        ));
      });
      //final result = await estadopagoDao.findActividadById(18);
      //return await dato;
      return await estadopagoDao.findAllEstadoPago();
    }else{
      return await estadopagoDao.findAllEstadoPago();
    }
  }

  Future<GenericModelo> deleteEstadoPago(int id) async {
    final estadopagoDao= (await conetion()).estadopagoDao;
    if(await isConected()){
      estadopagoDao.deleteEstadoPago(id);
      return await estadopagoApi!.deleteEstadoPago(TokenUtil.TOKEN,id);
    }else{
      estadopagoDao.deleteEstadoPago(id);
      Map<String, dynamic> resultado = {'deleted':true};
      return Future.value(GenericModelo.fromJson(resultado));
    }
  }

  Future<EstadoPagoModelo> updateEstadoPago(int id, EstadoPagoModelo estadopago) async {
    final estadopagoDao= (await conetion()).estadopagoDao;
    if(await isConected()){
      return await estadopagoApi!.updateEstadoPago(TokenUtil.TOKEN, id, estadopago);
    }else{
      estadopagoDao.updateEstadoPago(estadopago);
      return estadopago;
    }
  }

  Future<EstadoPagoModelo> createEstadoPago(EstadoPagoModelo estadopago) async {
    final estadopagoDao= (await conetion()).estadopagoDao;
    if(await isConected()){
      return await estadopagoApi!.crearEstadoPago(TokenUtil.TOKEN, estadopago);
    }else{
      estadopagoDao.insertEstadoPago(estadopago);
      return await estadopago;
    }
  }


}