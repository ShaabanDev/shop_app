import 'package:flutter/material.dart';

import 'package:shop_app/providers/product.dart';

class UserProductItem extends StatelessWidget {
  final Product product;
  UserProductItem(
    this.product,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Expanded(child: Text(product.title)),
      trailing: Row(
        children: [
          Expanded(child: IconButton(onPressed: () {}, icon: Icon(Icons.edit))),
          Expanded(
              child: IconButton(onPressed: () {}, icon: Icon(Icons.delete))),
        ],
      ),
    );
  }
}
