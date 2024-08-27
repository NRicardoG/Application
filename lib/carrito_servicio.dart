import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class CarritoService extends GetxService {
  var productos = <Map<String, dynamic>>[].obs;

  Future<void> agregarProducto(
      BuildContext context, String codigoProducto) async {
    final pr = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false);
    pr.style(
      message: 'Buscando producto...',
    );
    pr.show();

    final url = 'http://192.168.1.10:3000/product/${codigoProducto}';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      data['IMAGE'] = 'http://192.168.1.10:3000/${data['IMAGE']}';
      Map<String, dynamic> nuevoProducto = data;

      // Agregar mapas a la lista
      productos.add(nuevoProducto);

      Get.snackbar('Producto Escaneado', data['NAME']);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      Get.snackbar('Error', data['status']);
    }
    pr.hide();
  }
}
