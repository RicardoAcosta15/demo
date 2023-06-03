// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  String nombre;
  String apellido;
  String cedula;
  String sexo;
  String id;

  Usuario({
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.sexo,
    required this.id,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        apellido: json["apellido"],
        cedula: json["cedula"],
        sexo: json["sexo"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "cedula": cedula,
        "sexo": sexo,
        "Id": id,
      };
}
