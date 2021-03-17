class Producto {
  final String id;
  final String nombre;
  final String descripcion;
  final int cantidad;
  final double precio;

  Producto(
      {this.id, this.nombre, this.descripcion, this.cantidad, this.precio});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'cantidad': cantidad,
      'precio': precio
    };
  }

  Producto.fromFirestore(Map firestore)
      : id = firestore['id'],
        nombre = firestore['nombre'],
        descripcion = firestore['descripcion'],
        cantidad = firestore['cantidad'],
        precio = firestore['precio'];
}
