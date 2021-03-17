import 'package:flutter/material.dart';
import 'package:markapp_prueba/models/producto_model.dart';
import 'package:markapp_prueba/pages/editar_producto.dart';
import 'package:markapp_prueba/providers/producto_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Carrito extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print(index);
    if (index == 1) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EditarProducto()));
    }
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    final products = Provider.of<List<Producto>>(context);
    final productoProvider = Provider.of<ProductoProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'oe',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 8.0),
                  Text(
                    'Carrito de compras',
                    style: TextStyle(color: Colors.grey[700], fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: (products != null)
                  ? Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: productoProvider.productos.length,
                            itemBuilder: (context, index) {
                              return ListaCarrito(
                                  productoProvider.productos, context, index);
                            }),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
            Total()
          ],

          //Total(),
        ));
    //bottomNavigationBar: BottomNavBar());
  }

  Widget BottomNavBar() {
    return BottomNavigationBar(
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
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  Widget ListaCarrito(listaProductos, context, index) {
    final productoProvider = Provider.of<ProductoProvider>(context);

    final formatCurrency = new NumberFormat.simpleCurrency();
    print(listaProductos.length);

    if (listaProductos.length > 0) {
      return Container(
        //padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 130.0,
        width: double.maxFinite,
        child: Card(
          child: Column(
            children: [
              ListTile(
                leading: Image.network(
                  'https://oechsle.vteximg.com.br/arquivos/ids/2474851-1000-1000/1743121.jpg?v=637495967459370000',
                  height: 95,
                  width: 95,
                  //fit: BoxFit.cover,
                ), //FlutterLogo(size: 72.0),
                title: Text(listaProductos[index].nombre,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                subtitle: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Cantidad',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0)),
                        SizedBox(width: 58.0),
                        Text(listaProductos[index].cantidad.toString(),
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0),
                            textAlign: TextAlign.justify),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Ahora',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0)),
                        SizedBox(width: 75.0),
                        Text('1',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0),
                            textAlign: TextAlign.justify),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(3),
                          child: Text('oe!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  backgroundColor: Colors.red)),
                        ),
                        SizedBox(width: 75.0),
                        Text(
                            NumberFormat.simpleCurrency()
                                .format(listaProductos[index].precio)
                                .toString(),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.justify),
                      ],
                    ),
                  ],
                ), //Text(products[index].descripcion),
                trailing: IconButton(
                  icon: new Icon(Icons.delete),
                  onPressed: () {
                    print('eliminar');
                    productoProvider.removeProductCar(index);
                  },
                ),

                isThreeLine: true,
                /*  onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditarProducto(products[index])));
              }, */
              ),
            ],
          ),
        ),
      );
    } else {
      return Text('Carrito vacio');
    }
  }

  Widget Total() {
    final productoProvider = Provider.of<ProductoProvider>(context);
    var total = 0.0;

    if (productoProvider.productos.length > 0) {
      print('ssssss');
      productoProvider.productos.forEach((element) {
        //total += element.precio.toInt();
        print(element);
        total += element.precio * element.cantidad;
      });
    }

    return Container(
      decoration: BoxDecoration(color: Colors.grey[400]),
      child: Column(
        children: [
          ListTile(
            //FlutterLogo(size: 72.0),
            title: Text('TOTAL A PAGAR',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold)),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Ahora',
                        style:
                            TextStyle(color: Colors.black87, fontSize: 12.0)),
                    SizedBox(width: 68.0, height: 20.0),
                    Text(
                        NumberFormat.simpleCurrency()
                            .format(total + 12.0)
                            .toString(),
                        style: TextStyle(color: Colors.black87, fontSize: 13.0),
                        textAlign: TextAlign.justify),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.all(3),
                      child: Text('oe!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              backgroundColor: Colors.red)),
                    ),
                    SizedBox(width: 75.0),
                    Text(NumberFormat.simpleCurrency().format(total).toString(),
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.justify),
                  ],
                ),
              ],
            ), //Text(products[index].descripcion),
            trailing: MaterialButton(
                child: Text('Siguiente'),
                color: Colors.red,
                textColor: Colors.white,
                shape: StadiumBorder(),
                onPressed: () {
                  print('guardar carrito');
                }),

            isThreeLine: true,
            onTap: () {
              /*  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditarProducto(products[index]))); */
            },
          ),
        ],
      ),
    );
  }
}
