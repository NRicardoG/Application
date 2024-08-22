// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lector_facturacion/carro_compra/carrito_servicio.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:flutter/material.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
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
      subtitle: Text('Código: ${producto['id']}'),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(producto['urlImagen']),
      ),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          setState(() {
            carritoService.productos.removeAt(index); // Elimina el producto
          });
        },
      ),
    );
  },
);

      }),



      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Text(
              'Total de artículos: ${carritoService.productos.length}',  //contador
              style: const TextStyle(fontSize: 16),
            )),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
               //Para generar factura jiji
              },
              child: const Text('Pagar en caja'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ));
        
    
    
    
    
    
    
    
  }
}

