import 'dart:async';
import 'package:asistencia_app/apis/EstadoPago_api.dart';
import 'package:asistencia_app/comp/DropDownFormField.dart';
import 'package:asistencia_app/modelo/EstadoPagoModelo.dart';
import 'package:asistencia_app/theme/AppTheme.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class EstadoPagoForm extends StatefulWidget {
  @override
  _EstadoPagoFormState createState() => _EstadoPagoFormState();
}

class _EstadoPagoFormState extends State<EstadoPagoForm> {
  late String _nombre = "";
  late String _descripcion = "";

  final _formKey = GlobalKey<FormState>();

  void capturaNombre(valor) {
    this._nombre = valor;
  }

  void capturaDescripcion(valor) {
    this._descripcion = valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. EstadoPago"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildDatoCadena(capturaNombre, "Nombre:"),
                _buildDatoCadena(capturaDescripcion, "Descripcion:"),
                // Agregar más campos según tus necesidades

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Procesando datos'),
                              ),
                            );
                            _formKey.currentState!.save();
                            // Crear una instancia del modelo EstadoPagoModelo con los valores capturados
                            EstadoPagoModelo estadoPagoModelo = EstadoPagoModelo(
                              id: 0, // El ID debe asignarse de acuerdo a tu lógica
                              nombre: _nombre,
                              descripcion: _descripcion,
                            );

                            // Aquí puedes llamar a un método para enviar el modelo a la API o hacer otras operaciones

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Los datos del formulario no son válidos'),
                              ),
                            );
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatoCadena(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }
}
