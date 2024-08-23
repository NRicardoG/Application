import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  var valorCodigoBarras = '';
  var productos = <Map<String, dynamic>>[].obs;

  Future<void> escanearCodigoBarras(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancelar',
      true,
      ScanMode.BARCODE,
    );

    if (barcodeScanRes == '-1') {
      Get.snackbar('Cancelado', 'Lectura Cancelada');
    } else {
      // Simular la adición de producto
      final producto = {
        'nombre': 'Producto $barcodeScanRes',
        'cantidad': 1,
        'precio': 10.0, // Ejemplo de precio, puedes modificarlo según tu lógica
      };

      productos.add(producto);
      valorCodigoBarras = barcodeScanRes;
      update();
    }
  }
}
