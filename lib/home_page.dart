import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lector_facturacion/home_page_controller.dart';
import 'package:lector_facturacion/carrito_page.dart'; // Importa la página del carrito

class HomePage extends StatelessWidget {
  HomePage() {
    Get.put(HomePageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicación de santiago'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Escaner productos',
              style: Get.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            GetBuilder<HomePageController>(
              builder: (controller) {
                return Text(
                  controller.valorCodigoBarras,
                  style: Get.theme.textTheme.headlineMedium,
                );
              },
            ),
            SizedBox(height: 10),
            TextButton.icon(
              icon: Image.asset(
                'assets/icon.png',
                width: 50,
              ),
              label: Text(
                'Escanear Codigo',
                style: Get.theme.textTheme.headlineMedium,
              ),
              onPressed: () => Get.find<HomePageController>().escanearCodigoBarras(context),
            ),
            SizedBox(height: 20),
            TextButton.icon(
              icon: Icon(Icons.shopping_cart),
              label: Text(
                'Ver Carrito',
                style: Get.theme.textTheme.headlineMedium,
              ),
              onPressed: () => Get.to(CarritoPage()),
            ),
          ],
        ),
      ),
    );
  }
}
