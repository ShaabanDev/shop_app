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
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Spacer(),
                Chip(
                    label: Text("\$${cart.totalAmount.toStringAsFixed(2)}"),
                    backgroundColor: Theme.of(context).primaryColor),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "ORDER NOW",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
              ],
            ),
            Text("data")
          ],
        ),
      ),
    );
  }
}
