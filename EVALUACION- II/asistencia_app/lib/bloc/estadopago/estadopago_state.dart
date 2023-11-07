part of 'estadopago_bloc.dart';

@immutable
abstract class EstadoPagoState {}

class EstadoPagoInitialState extends EstadoPagoState {}
class EstadoPagoLoadingState extends EstadoPagoState{}
class EstadoPagoLoadedState extends EstadoPagoState{
  List<EstadoPagoModelo> EstadoPagoList;
  EstadoPagoLoadedState(this.EstadoPagoList);
}
class EstadoPagoError extends EstadoPagoState{
  Error e;
  EstadoPagoError(this.e);
}
