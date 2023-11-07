import 'dart:async';

import 'package:asistencia_app/modelo/EstadoPagoModelo.dart';
import 'package:asistencia_app/repository/EstadoPagoRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'estadopago_event.dart';
part 'estadopago_state.dart';

class EstadoPagoBloc extends Bloc<EstadoPagoEvent, EstadoPagoState> {
  final EstadoPagoRepository _estadopagoRepository;

  EstadoPagoBloc(this._estadopagoRepository) : super(EstadoPagoInitialState());

  @override
  Stream<EstadoPagoState> mapEventToState(EstadoPagoEvent event) async* {
    if (event is ListarEstadoPagoEvent) {
      yield EstadoPagoLoadingState();
      try {
        final List<EstadoPagoModelo> estadoPagoList = await _estadopagoRepository.getEstadoPago();
        yield EstadoPagoLoadedState(estadoPagoList);
      } catch (e) {
        yield EstadoPagoError(e as Error);
      }
    } else if (event is DeleteEstadoPagoEvent) {
      try {
        await _estadopagoRepository.deleteEstadoPago(event.estadoPago!.id);
        final List<EstadoPagoModelo> estadoPagoList = await _estadopagoRepository.getEstadoPago();
        yield EstadoPagoLoadedState(estadoPagoList);
      } catch (e) {
        yield EstadoPagoError(e as Error);
      }
    } else if (event is CreateEstadoPagoEvent) {
      try {
        await _estadopagoRepository.createEstadoPago(event.estadoPago!);
        final List<EstadoPagoModelo> estadoPagoList = await _estadopagoRepository.getEstadoPago();
        yield EstadoPagoLoadedState(estadoPagoList);
      } catch (e) {
        yield EstadoPagoError(e as Error);
      }
    } else if (event is UpdateEstadoPagoEvent) {
      try {
        await _estadopagoRepository.updateEstadoPago(event.estadoPago!.id, event.estadoPago!);
        final List<EstadoPagoModelo> estadoPagoList = await _estadopagoRepository.getEstadoPago();
        yield EstadoPagoLoadedState(estadoPagoList);
      } catch (e) {
        yield EstadoPagoError(e as Error);
      }
    }
  }
}
