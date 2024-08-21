// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lector_facturacion/carro_compra/carrito_servicio.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';


class CarritoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CarritoService carritoService = Get.find<CarritoService>();
    
    
    final ProgressDialog pr = ProgressDialog(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: carritoService.productos.length,
          itemBuilder: (context, index) {
            final producto = carritoService.productos[index];
            return ListTile(
              title: Text(producto['nombre']),
              subtitle: Text('Codigo: ${producto['id']}'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(producto['urlImagen']),
              ),
            );
          },
        );
      }),
    );
  }
}
