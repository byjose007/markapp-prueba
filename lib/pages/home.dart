import 'package:flutter/material.dart';
import 'package:markapp_prueba/pages/carrito.dart';
import 'package:markapp_prueba/pages/editar_producto.dart';
import 'package:markapp_prueba/pages/productos.dart';
import 'package:markapp_prueba/pages/prueba.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<Widget> _paginas = [
    Productos(),
    EditarProducto(),
    Carrito(),
  ];

  Widget _productos = Productos();
  Widget _edit = EditarProducto();
  Widget _car = Carrito();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        centerTitle: true,
        title: Text('Productos'),
      ), */
      body: _paginas[_currentIndex], //getBody(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Agregar producto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito de compras',
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    if (this._currentIndex == 0) {
      return this._productos;
    } else if (this._currentIndex == 1) {
      return this._edit;
    } else {
      return this._car;
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
