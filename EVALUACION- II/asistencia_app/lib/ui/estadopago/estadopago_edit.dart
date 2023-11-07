import 'package:asistencia_app/apis/actividad_api.dart';
import 'package:asistencia_app/apis/estadopago_api.dart';
import 'package:asistencia_app/comp/DropDownFormField.dart';
import 'package:asistencia_app/modelo/EstadoPagoModelo.dart';
import 'package:asistencia_app/modelo/EstadoPagoModelo.dart';
import 'package:asistencia_app/theme/AppTheme.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EstadoPagoFormEdit extends StatefulWidget {
  EstadoPagoModelo modelA;

  EstadoPagoFormEdit({required this.modelA}):super();

  @override
  _EstadoPagoFormEditState createState() => _EstadoPagoFormEditState(modelA: modelA);
}

class _EstadoPagoFormEditState extends State<EstadoPagoFormEdit> {
  EstadoPagoModelo modelA;
  _EstadoPagoFormEditState({required this.modelA}):super();

  late int _periodoId=0;
  late String _nombre="";
  late String _descripcion="";



  TextEditingController _horai = new TextEditingController();
  TextEditingController _minToler = new TextEditingController();
  TimeOfDay? selectedTime;

  late String _userCreate;
  var _data = [];

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );



  void capturaNombreAct(valor){ this._nombre=valor;}

  void capturaFecha(valor){ this._descripcion=valor;}



  @override
  Widget build(BuildContext context) {
    //getCurrentLocation();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Estado Pago"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              //color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    _buildDatoCadena(capturaNombreAct, modelA.nombre, "Nombre:"),
                    _buildDatoCadena(capturaNombreAct, modelA.descripcion, "Descripcion:"),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                                _formKey.currentState!.save();
                                EstadoPagoModelo mp = new EstadoPagoModelo.unlaunched();
                                mp.nombre = _nombre;
                                mp.descripcion = _descripcion;
                                
                                mp.id=modelA.id;

                                

                                var api = await Provider.of<EstadoPagoAPi>(
                                    context,
                                    listen: false)
                                    .updateEstadoPago(TokenUtil.TOKEN,modelA.id.toInt(), mp);
                                print("ver: ${api.toJson()}");
                                if (api.toJson()!=null) {
                                  Navigator.pop(context, () {
                                    setState(() {});
                                  });
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No estan bien los datos de los campos!'),
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
              ))),
    );
  }

  Widget _buildDatoEntero(Function obtValor, String _dato,String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: _dato,
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(int.parse(value!));
      },
    );
  }

  Widget _buildDatoCadena(Function obtValor,String _dato, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: _dato,
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Widget _buildDatoLista(Function obtValor,_dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: _dato,
      onSaved: (value) {
        setState(() {
          obtValor(value);
        });
      },
      onChanged: (value) {
        setState(() {
          obtValor(value);
        });
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }

  }
  
  Widget _buildDatoFecha(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      //controller: 
      keyboardType: TextInputType.datetime,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onTap: (){
        //_selectDate(context,obtValor);
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Future<void> _selectTime(BuildContext context,Function obtValor) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext? context, Widget? child){
          return MediaQuery(
            data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        }
    );
    /*if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        //obtValor("${selectedTime!.hour}:${selectedTime!.minute}");
        obtValor("${(selectedTime!.hour)<10?"0"+(selectedTime!.hour).toString():selectedTime!.hour}:${(selectedTime!.minute)<10?"0"+(selectedTime!.minute).toString():selectedTime!.minute}:00");
        //_horai.text="${selectedTime!.hour}:${selectedTime!.minute}";
      });
    }*/
  }

  Widget _buildDatoHora(Function obtValor, Function capControl, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: capControl(),
      keyboardType: TextInputType.datetime,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onTap: (){
       // _selectTime(context, obtValor);
      },
      onSaved: (String? value) {
        obtValor(value!);
        //_horai.text=value!;
      },
    );
  }

   /*Future<bool> permiso() async{
    bool serviceEnabled;
    LocationPermission permission;
   serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }*/

  /*Future<void>  getCurrentLocation() async {
    final hasPermission = await permiso();
    if (!hasPermission) {
      return;
    }
    if (mounted){
      Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true)
          .then((Position position) {
        if(mounted){
          setState(() {
            currentPosition = position;
            //getCurrentLocationAddress();
          });
        }
      }).catchError((e) {
        print(e);
      });
    }
  }*/