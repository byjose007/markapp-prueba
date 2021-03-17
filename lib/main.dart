import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:markapp_prueba/pages/home.dart';
import 'package:markapp_prueba/pages/productos.dart';
import 'package:markapp_prueba/providers/producto_provider.dart';
import 'package:markapp_prueba/services/firestorage_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductoProvider()),
        StreamProvider(create: (context) => firestoreService.getProducts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Home(),
      ),
    );
  }
}
