import 'package:flutter/material.dart';
import 'package:markapp_prueba/models/producto_model.dart';
import 'package:markapp_prueba/pages/productos.dart';
import 'package:markapp_prueba/services/firestorage_service.dart';
import 'package:uuid/uuid.dart';

class ProductoProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _id;
  String _nombre;
  String _descripcion;
  int _cantidad;
  double _precio;
  var uuid = Uuid();
  List<Producto> _products = [];

  //Getters
  String get nombre => _nombre;
  String get descripcion => _descripcion;
  int get cantidad => _cantidad;
  double get precio => _precio;
  List<Producto> get productos => _products;

  //Setters
  cambiarNombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  cambiarDescripcion(String value) {
    _descripcion = value;
    notifyListeners();
  }

  cambiarCantidad(String value) {
    _cantidad = int.parse(value);

    notifyListeners();
  }

  cambiarPrecio(String value) {
    _precio = double.parse(value);
    notifyListeners();
  }

  addProduct(Producto value) {
    _products.add(value);
    notifyListeners();
  }

  removeProductCar(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  loadValues(Producto product) {
    _nombre = product.nombre;
    _precio = product.precio;
    _cantidad = product.cantidad;
    _descripcion = product.descripcion;
    _id = product.id;
  }

  saveProduct() {
    print(_id);
    if (_id == null) {
      var nuevoProducto = Producto(
          id: uuid.v4(),
          nombre: nombre,
          descripcion: descripcion,
          cantidad: cantidad,
          precio: precio);
      firestoreService.saveProduct(nuevoProducto);
    } else {
      //Update
      var actualizarProducto = Producto(
          id: _id,
          nombre: _nombre,
          descripcion: _descripcion,
          cantidad: _cantidad,
          precio: _precio);
      firestoreService.updateProduct(actualizarProducto);
    }
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }

  saveCar(Producto product) {
    firestoreService.saveShopCar(product);
  }
}
