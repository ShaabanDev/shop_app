import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ProductsProvider()),
          ChangeNotifierProvider.value(value: Cart())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "My Shop",
          home: ProductOverviewScreen(),
          theme: ThemeData(
              primaryColor: Colors.purple, accentColor: Colors.deepOrange),
          routes: {
            CartSceen.routeName: (_) => CartSceen(),
          },
        ));
  }
}
