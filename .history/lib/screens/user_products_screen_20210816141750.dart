import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

import './edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/user-products";
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsProvider>(context);
    Future<void> _refresh(BuildContext context) async
    {
      await Provider.of<ProductsProvider>(context).fetchAndSettProducts();
    }
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Your Products"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName);
                },
                icon: Icon(Icons.add)),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()=>,
        child: ListView.builder(
            itemCount: product.items.length,
            itemBuilder: (ctx, i) => UserProductItem(product.items[i])),
      ),
    );
  }
}
