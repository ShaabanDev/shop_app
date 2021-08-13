import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                size: 30,
                color: Colors.white,
              ),
            ],
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        color: Theme.of(context).errorColor,
      ),
      key: ValueKey(id),
      confirmDismiss: (directio) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                content:
                    Text("Are You Want To Remove The Item From The Cart ? "),
                title: Text("Are You Sute"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text("Yes")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text("No"))
                ],
              );
            });
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context).removeItem(productId);
        // the method should done after the dismissing
      },
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
