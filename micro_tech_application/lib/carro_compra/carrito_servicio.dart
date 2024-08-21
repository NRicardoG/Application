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

    final url =
        'https://world.openfoodfacts.org/api/v2/product/${codigoProducto}.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      final data = jsonDecode(response.body);

      if (data['status'] == 0) {
        Get.snackbar('Error', 'Producto no encontrado');
      } else {
        var nombreProducto = data['product']['product_name'] ??
            data['product']['generic_name'] ??
            'Nombre no encontrado';

        Map<String, dynamic> nuevoProducto = {
          'id': codigoProducto,
          'nombre': nombreProducto,
          'urlImagen': data['product']['image_front_small_url'],
        };

        // Agregar mapas a la lista
        productos.add(nuevoProducto);

        Get.snackbar('Codigo Escaneado', nombreProducto);
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      Get.snackbar('Error', 'Error al escanear el código de barras');
    }
    pr.hide();
  }
}
