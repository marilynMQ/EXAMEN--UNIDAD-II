part of 'estadopago_bloc.dart';

@immutable
abstract class EstadoPagoEvent {}
class ListarEstadoPagoEvent extends EstadoPagoEvent{
  ListarEstadoPagoEvent(){print("Evento si");}
//ListarEstadoPagoEvent({required estadopagoModelo estadopago}):super(estadopago:estadopago);
}
class DeleteEstadoPagoEvent extends EstadoPagoEvent{
  EstadoPagoModelo estadopago;
  DeleteEstadoPagoEvent(this.estadopago);
//DeleteEstadoPagoEvent({required estadopagoModelo estadopago}):super(estadopago:estadopago);
}
class UpdateEstadoPagoEvent extends EstadoPagoEvent{
  EstadoPagoModelo estadopago;
  UpdateEstadoPagoEvent(this.estadopago);
//UpdateEstadoPagoEvent({required estadopagoModelo estadopago}):super(estadopago:estadopago);
}
class CreateEstadoPagoEvent extends EstadoPagoEvent{
  EstadoPagoModelo estadopago;
  CreateEstadoPagoEvent(this.estadopago);
//CreateEstadoPagoEvent({required estadopagoModelo estadopago}):super(estadopago:estadopago);
}
