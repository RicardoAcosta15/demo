import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/controller.dart';

// ignore: must_be_immutable
class CrearEditarUsuariosScreen extends StatefulWidget {
  CrearEditarUsuariosScreen(
      {super.key, required this.tituloAppBar,
      this.nombre,
      this.apellido,
      this.sexo,
      this.cedula,
      this.id});
  String tituloAppBar;
  String? nombre;
  String? apellido;
  String? sexo;
  String? cedula;
  String? id;

  @override
  State<CrearEditarUsuariosScreen> createState() =>
      _CrearEditarUsuariosScreenState();
}

class _CrearEditarUsuariosScreenState extends State<CrearEditarUsuariosScreen> {
  final formkey = GlobalKey<FormState>();
  String cedulaAc = "";
  String nombreAc = "";
  String apellidoAc = "";
  String sexoAc = "Masculino";
  @override
  void initState() {
    super.initState();
    sexoAc = widget.sexo ?? sexoAc;
    cedulaAc = widget.cedula ?? "";
    nombreAc = widget.nombre ?? "";
    apellidoAc = widget.apellido ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
              key: formkey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.tituloAppBar,
                      style:
                          const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      initialValue: nombreAc,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Nombre',
                          prefixIcon: Icon(Icons.text_fields_outlined,
                              color: Theme.of(context).primaryColor)),
                      onChanged: (value) {
                        setState(() {
                          nombreAc = value;
                          debugPrint(nombreAc);
                        });
                      },
                      validator: (value) {
                        if (value!.length < 4 || value.isEmpty) {
                          return "Favor ingresar nombre completo.";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      initialValue: apellidoAc,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Apellido',
                          prefixIcon: Icon(Icons.text_fields_outlined,
                              color: Theme.of(context).primaryColor)),
                      onChanged: (value) {
                        setState(() {
                          apellidoAc = value;
                          debugPrint(apellidoAc);
                        });
                      },
                      validator: (value) {
                        if (value!.length < 3 || value.isEmpty) {
                          return "Favor ingresar el apellido completo.";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: sexoAc,
                      decoration: textInputDecoration.copyWith(
                          prefixIcon: sexoAc == 'Masculino'
                              ? const Icon(Icons.person_outline)
                              : const Icon(Icons.person_2_outlined)),
                      hint: const Text('Seleccione un género'),
                      onChanged: (newValue) {
                        setState(() {
                          sexoAc = newValue!;
                        });
                      },
                      items: <String>['Masculino', 'Femenino']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      initialValue: cedulaAc,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: textInputDecoration.copyWith(
                          labelText: '000-0000000-0',
                          prefixIcon: Icon(Icons.credit_card_outlined,
                              color: Theme.of(context).primaryColor)),
                      onChanged: (value) {
                        setState(() {
                          cedulaAc = value;
                          debugPrint(cedulaAc);
                        });
                      },
                      validator: (value) {
                        if (value!.length < 9 || value.isEmpty) {
                          return "Favor ingresar la cedula completa.";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              widget.tituloAppBar == 'Crear Usuario'
                                  ? FirestoreService(null).guardarDataUsuario(
                                      nombre: nombreAc,
                                      sexo: sexoAc,
                                      apellido: apellidoAc,
                                      cedula: cedulaAc)
                                  : FirestoreService(null)
                                      .actualizarDataUsuario(
                                          usuarioId: widget.id!,
                                          nombre: nombreAc,
                                          sexo: sexoAc,
                                          apellido: apellidoAc,
                                          cedula: cedulaAc);
                            } else {
                              Get.showSnackbar(const GetSnackBar(
                                  title: 'Campos Imcompletos.',
                                  message: 'Favor completar todos los campos.',
                                  backgroundColor: Colors.red));
                            }
                          },
                          child: Text(
                            widget.tituloAppBar == 'Crear Usuario'
                                ? 'Guardar'
                                : 'Actualizar',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

   var textInputDecoration = const InputDecoration(
      labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2)));



}