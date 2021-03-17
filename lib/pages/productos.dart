import 'package:flutter/material.dart';
import 'package:markapp_prueba/models/producto_model.dart';
import 'package:markapp_prueba/pages/editar_producto.dart';
import 'package:markapp_prueba/providers/producto_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Productos extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
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
                  //Icon(Icons.shopping_cart),
                  SizedBox(width: 8.0),
                  Text(
                    'Productos',
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
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return ListaProductos(products, context, index);
                            }),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],

          //Total(),
        ));
    //bottomNavigationBar: BottomNavBar());
  }

  Widget ListaProductos(products, context, index) {
    final productoProvider = Provider.of<ProductoProvider>(context);
    final formatCurrency = new NumberFormat.simpleCurrency();

    return Container(
      //padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 145.0,
      width: double.maxFinite,
      child: Card(
        child: Column(
          children: [
            SizedBox(height: 15.0),
            ListTile(
              leading: Image.network(
                'https://oechsle.vteximg.com.br/arquivos/ids/2474851-1000-1000/1743121.jpg?v=637495967459370000',
                height: 95,
                width: 95,

                //fit: BoxFit.cover,
              ), //FlutterLogo(size: 72.0),
              title: Text(products[index].nombre,
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
                          style:
                              TextStyle(color: Colors.black87, fontSize: 12.0)),
                      SizedBox(
                        width: 50.0,
                        height: 20,
                      ),
                      Text(products[index].cantidad.toString(),
                          style:
                              TextStyle(color: Colors.black87, fontSize: 12.0),
                          textAlign: TextAlign.justify),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Ahora',
                          style:
                              TextStyle(color: Colors.black87, fontSize: 12.0)),
                      SizedBox(width: 65.0),
                      Text(
                          NumberFormat.simpleCurrency()
                              .format(products[index].precio + 12.0)
                              .toString(),
                          style:
                              TextStyle(color: Colors.black87, fontSize: 12.0),
                          textAlign: TextAlign.justify),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.0),
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
                              .format(products[index].precio)
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
                icon: new Icon(Icons.shopping_basket_sharp,
                    color: Colors.red, size: 45.0),
                onPressed: () {
                  print('eliminar');
                  productoProvider.addProduct(products[index]);
                },
              ),

              isThreeLine: true,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditarProducto(products[index])));
              },
            ),
          ],
        ),
      ),
    );
  }
}
