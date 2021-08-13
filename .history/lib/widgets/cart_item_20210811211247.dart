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
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        color: Theme.of(context).errorColor,
      ),
      key: ValueKey(id),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: ListTile(
          title: Text(title),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: FittedBox(child: Text("\$${price.toStringAsFixed(2)}")),
              ),
            ),
          ),
          trailing: Text("$quantity x"),
          subtitle: Text("Total:\$${(price * quantity).toStringAsFixed(2)}"),
        ),
      ),
    );
  }
}
