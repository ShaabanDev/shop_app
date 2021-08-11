import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int productIndex = Provider.of<ProductsProvider>(context).items.length;

    return Scaffold(
        appBar: AppBar(
          title: Text("Shop App"),
        ),
        body: GridView.builder(
            itemCount: productIndex,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, productIndex) => ProductItem()));
  }
}
