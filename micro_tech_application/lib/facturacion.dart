import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lector_facturacion/escaneo_producto/home_page.dart';
import 'package:lector_facturacion/escaneo_producto/home_page_controller.dart';

void main() {
  // Inicializar GetX
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(HomePageController()); 
  runApp(Facturacionapp());
}

class Facturacionapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Facturación Electrónica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFFAFAFA),
      ),
      home: FacturacionScreen(),
    );
  }
}

class FacturacionScreen extends StatefulWidget {
  @override
  _FacturacionScreenState createState() => _FacturacionScreenState();
}

class _FacturacionScreenState extends State<FacturacionScreen> {
  final HomePageController _homePageController = Get.find<HomePageController>();
  final List<Map<String, dynamic>> _productos = [];
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    // Escuchar los cambios en el carrito
    _homePageController.addListener(() {
      setState(() {
        _productos.clear();
        _productos.addAll(_homePageController.productos);
        _total = _productos.fold(0.0, (sum, item) => sum + item['precio']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MicroTech Solutions',
            style: TextStyle(color: Color(0xFFFAFAFA))),
        backgroundColor: Color(0xFF7E57C2),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Datos tienda',
                style: TextStyle(color: Color(0xFF455A64))),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _productos.length,
              itemBuilder: (context, index) {
                final producto = _productos[index];
                return Card(
                  color: Color.fromARGB(255, 243, 238, 251),
                  child: ListTile(
                    title:
                        Text('${producto['nombre']} (${producto['cantidad']})'),
                    trailing: Text('\$${producto['precio']}'),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Total: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${_total.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF09184D),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                backgroundColor: Color(0xFF09184D),
                selectedItemColor: Color(0xFFFAFAFA),
                unselectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                    if (index == 1) {
                      Get.to(() => HomePage());
                    } else if (index == 0) {
                      Get.to(() => FacturacionScreen());
                    }
                  });
                },
                items: [
                  _buildNavItem(Icons.home, 'Inicio', 0),
                  _buildNavItem(Icons.qr_code, 'QR', 1),
                  _buildNavItem(Icons.attach_money, 'Pago', 2),
                  _buildNavItem(Icons.person, 'Perfil', 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedIndex == index ? Colors.white : Colors.transparent,
        ),
        padding: EdgeInsets.all(10),
        child: Icon(
          icon,
          color: _selectedIndex == index ? Color(0xFF09184D) : Colors.white,
        ),
      ),
      label: label,
    );
  }
}
