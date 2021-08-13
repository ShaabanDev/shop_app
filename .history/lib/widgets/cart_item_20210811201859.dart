import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.productId,
      required this.title,
      required this.quantity,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text("\$${quantity * price}"),
        ),
        trailing: Text(quantity.toString()),
      ),
    );
  }
}
