import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< Updated upstream
import 'package:lector_facturacion/carro_compra/carrito_servicio.dart';
import 'package:lector_facturacion/escaneo_producto/home_page.dart';

=======
import 'package:lector_facturacion/carrito_servicio.dart';
import 'package:lector_facturacion/home_page.dart';
>>>>>>> Stashed changes


void main() {
  Get.put(CarritoService()); // Registramos el servicio del carrito
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
