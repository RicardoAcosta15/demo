import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirestoreService {
  final String? usuarioId;

  FirestoreService(this.usuarioId);

  final CollectionReference usuarioCollection =
      FirebaseFirestore.instance.collection("usuarios");

//guardar datos usuario
  Future<void> guardarDataUsuario({
    required String nombre,
    required String apellido,
    required String sexo,
    required String cedula,
  }) async {
    try {
      final docUser = FirebaseFirestore.instance.collection("usuarios").doc();

      await docUser.set({
        "Id": docUser.id,
        "nombre": nombre,
        "apellido": apellido,
        "sexo": sexo,
        "cedula": cedula,
      });

      Get.back();
      Get.showSnackbar(GetSnackBar(
        title: 'Usuario Creado',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        message: 'El usuario de $nombre fue creado exitosamente.',
      ));
    } catch (e) {
      if (kDebugMode) {
        print('Error al guardar los datos del usuario: $e');
      }
    }
  }

  //traer todos los usuarios
  Future getTodosUsuarios(String rol) async {
    return usuarioCollection.snapshots();
  }

  Future<bool> actualizarDataUsuario({
    required String usuarioId,
    required String nombre,
    required String apellido,
    required String sexo,
    required String cedula,
  }) async {
    try {
      DocumentReference usuarioDocumentReference =
          usuarioCollection.doc(usuarioId);

      await usuarioDocumentReference.update({
        "nombre": nombre,
        "apellido": apellido,
        "sexo": sexo,
        "cedula": cedula
      });

      Get.back();
      Get.showSnackbar(GetSnackBar(
        title: 'Usuario Actualizado ',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        message: 'El usuario de $nombre fue actualizado.',
      ));

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error al actualizar los datos del usuario: $e');
      }
      return false;
    }
  }
}
