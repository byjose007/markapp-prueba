import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:markapp_prueba/models/producto_model.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveProduct(Producto product) {
    return _db
        .collection('markapp-products')
        .doc(product.id)
        .set(product.toMap());
  }

  Future<void> saveShopCar(Producto product) {
    return _db
        .collection('markapp-shop-car')
        .doc(product.id)
        .set(product.toMap());
  }

  Future<void> updateProduct(Producto product) {
    return _db
        .collection('markapp-products')
        .doc(product.id)
        .update(product.toMap());
  }

  Stream<List<Producto>> getProducts() {
    return _db.collection('markapp-products').snapshots().map((snapshot) =>
        snapshot.docs
            .map((document) => Producto.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeProduct(String productId) {
    return _db.collection('markapp-products').doc(productId).delete();
  }
}
