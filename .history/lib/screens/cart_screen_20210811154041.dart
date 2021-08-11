import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartSceen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Card(
        child: Column(
          children: [
            Row(
              children: [
                Text("Total"),
                Chip(
                    label: Text("\$${cart.totalAmount}"),
                    backgroundColor: Theme.of(context).primaryColor)
              ],
            )
          ],
        ),
      ),
    );
  }
}
