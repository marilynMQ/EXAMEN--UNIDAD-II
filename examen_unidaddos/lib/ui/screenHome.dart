import 'package:flutter/material.dart';
import 'package:examen_unidaddos/modelo/estadopagoModelo.dart';
import 'package:examen_unidaddos/apis/estadopago_api.dart';

class EstadopagoScreen extends StatefulWidget {
  @override
  _EstadopagoScreenState createState() => _EstadopagoScreenState();
}

class _EstadopagoScreenState extends State<EstadopagoScreen> {
  List<EstadopagoModelo> estadosPago = [];
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  EstadopagoModelo? selectedEstadopago;
  bool isEditing = false; // Variable para rastrear el modo de edición

  @override
  void initState() {
    super.initState();
    loadEstadosPago();
  }

  Future<void> loadEstadosPago() async {
    try {
      final api = EstadopagoApi.create();
      final estados = await api.listEstadospago();
      setState(() {
        estadosPago = estados;
      });
    } catch (e) {
      print("Error al cargar la lista de estados de pago: $e");
    }
  }

  Future<void> deleteEstadopago(int id) async {
    try {
      final api = EstadopagoApi.create();
      await api.deleteEstadopago(id);
      await loadEstadosPago();
    } catch (e) {
      print("Error al eliminar el estado de pago: $e");
    }
  }

  Future<void> createEstadopago() async {
    final String nombre = nombreController.text;
    final String descripcion = descripcionController.text;

    if (nombre.isEmpty || descripcion.isEmpty) {
      print("Por favor, complete todos los campos");
      return;
    }

    try {
      final api = EstadopagoApi.create();
      final newEstadopago = EstadopagoModelo(
        idEstadop: 0,
        nombre: nombre,
        descripcion: descripcion,
      );

      await api.creaEstadopago(newEstadopago);
      await loadEstadosPago();
      nombreController.clear();
      descripcionController.clear();
      // Cambiar el estado para volver al modo de creación
      setState(() {
        isEditing = false;
      });
    } catch (e) {
      print("Error al crear el estado de pago: $e");
    }
  }

  Future<void> editEstadopago(EstadopagoModelo estadoPago) {
    setState(() {
      selectedEstadopago = estadoPago;
      nombreController.text = estadoPago.nombre;
      descripcionController.text = estadoPago.descripcion;
      // Cambiar el estado para entrar en modo edición
      isEditing = true;
    });

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estados de Pago'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: nombreController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: descripcionController,
                  decoration: InputDecoration(labelText: 'Descripción'),
                ),
                Visibility(
                  visible: !isEditing, // Mostrar el botón de "Crear" si no estás en modo edición
                  child: ElevatedButton(
                    onPressed: () {
                      createEstadopago();
                      nombreController.clear();
                      descripcionController.clear();
                      loadEstadosPago();
                    },
                    child: Text('Crear',style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.pink), // Color rosa
                      textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.white), // Texto en blanco
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isEditing, // Mostrar el botón de "Actualizar" si estás en modo edición
                  child: ElevatedButton(
                    onPressed: () {
                      updateEstadopago();
                      nombreController.clear();
                      descripcionController.clear();
                      loadEstadosPago();
                      setState(() {
                        isEditing = false; // Cambiar a modo de creación después de actualizar
                      });
                    },
                    child: Text('Actualizar',style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.pink), // Color rosa
                      textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.red), // Texto en blanco
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          estadosPago.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView.builder(
              itemCount: estadosPago.length,
              itemBuilder: (context, index) {
                final estadoPago = estadosPago[index];
                return ListTile(
                  title: Text(estadoPago.nombre),
                  subtitle: Text(estadoPago.descripcion),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.pink), // Icono rosa
                        onPressed: () {
                          editEstadopago(estadoPago);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.pink), // Icono rosa
                        onPressed: () {
                          deleteEstadopago(estadoPago.idEstadop);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateEstadopago() async {
    if (selectedEstadopago == null) {
      return;
    }

    final String nombre = nombreController.text;
    final String descripcion = descripcionController.text;

    if (nombre.isEmpty || descripcion.isEmpty) {
      print("Por favor, complete todos los campos");
      return;
    }

    try {
      final api = EstadopagoApi.create();
      final updatedEstadopago = EstadopagoModelo(
        idEstadop: selectedEstadopago!.idEstadop,
        nombre: nombre,
        descripcion: descripcion,
      );

      await api.updateEstadopago(selectedEstadopago!.idEstadop, updatedEstadopago);
      await loadEstadosPago();
      selectedEstadopago = null;
      nombreController.clear();
      descripcionController.clear();
    } catch (e) {
      print("Error al actualizar el estado de pago: $e");
    }
  }
}
