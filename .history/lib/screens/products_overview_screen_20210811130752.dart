import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_grid.dart';
import 'package:shop_app/widgets/product_item.dart';

enum FilterOption { All, Favorites }

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  final bool showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (ctx) => [
                PopupMenuItem(child: Text("All Products"),
               ),
                PopupMenuItem(
                  child: Text("Only Favorites"),
               ),

                )
              ],
            )
          ],
          title: Text("Shop App"),
        ),
        body: ProductGrid());
  }
}
