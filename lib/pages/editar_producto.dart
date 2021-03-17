import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:markapp_prueba/models/producto_model.dart';
import 'package:markapp_prueba/providers/producto_provider.dart';
import 'package:provider/provider.dart';

class EditarProducto extends StatefulWidget {
  final Producto producto;

  EditarProducto([this.producto]);

  @override
  _EditarProductoState createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto> {
  final nombreController = TextEditingController();
  final descripcionController = TextEditingController();
  final cantidadController = TextEditingController();
  final precioController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    descripcionController.dispose();
    cantidadController.dispose();
    precioController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.producto == null) {
      //New Record
      nombreController.text = "";
      descripcionController.text = "";
      cantidadController.text = "";
      precioController.text = "";
      new Future.delayed(Duration.zero, () {
        final productoProvider =
            Provider.of<ProductoProvider>(context, listen: false);
        productoProvider.loadValues(Producto());
      });
    } else {
      //Controller Update
      nombreController.text = widget.producto.nombre;
      descripcionController.text = widget.producto.descripcion;
      cantidadController.text = widget.producto.cantidad.toString();
      precioController.text = widget.producto.precio.toString();
      //State Update
      new Future.delayed(Duration.zero, () {
        final productoProvider =
            Provider.of<ProductoProvider>(context, listen: false);
        productoProvider.loadValues(widget.producto);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductoProvider>(context);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Producto')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nombreController,
              decoration: InputDecoration(hintText: 'Marca'),
              onChanged: (value) {
                productoProvider.cambiarNombre(value);
              },
            ),
            TextField(
              controller: descripcionController,
              decoration: InputDecoration(hintText: 'Descripcion'),
              onChanged: (value) {
                productoProvider.cambiarDescripcion(value)(value);
              },
            ),
            TextField(
              controller: cantidadController,
              decoration: InputDecoration(hintText: 'Cantidad'),
              onChanged: (value) {
                productoProvider.cambiarCantidad(value);
              },
            ),
            TextField(
              controller: precioController,
              decoration: InputDecoration(hintText: 'precio'),
              onChanged: (value) => productoProvider.cambiarPrecio(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: Colors.white),
                  primary: Colors.blue),
              child: Text('Guardar'),
              onPressed: () {
                productoProvider.saveProduct();
                Navigator.of(context).pop();
              },
            ),
            (widget.producto != null)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(color: Colors.white),
                        primary: Colors.red),
                    child: Text('Eliminar'),
                    onPressed: () {
                      productoProvider.removeProduct(widget.producto.id);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
