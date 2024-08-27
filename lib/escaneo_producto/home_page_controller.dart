import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:lector_facturacion/carro_compra/carrito_servicio.dart';

class HomePageController extends GetxController {
  var valorCodigoBarras = '';

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
      update();
      Get.find<CarritoService>().agregarProducto(context, barcodeScanRes);
    }
  }
}
