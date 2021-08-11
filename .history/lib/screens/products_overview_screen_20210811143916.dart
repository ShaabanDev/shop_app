import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/badge.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum FilterOption { All, Favorites }

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    var cartCount = Provider.of<Cart>(context).cartCount;

    return Scaffold(
        appBar: AppBar(
          actions: [
            Badge(
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {},
                  color: Colors.blue,
                ),
                value: cartCount.toString()),
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text("All Products"), value: FilterOption.All),
                PopupMenuItem(
                  child: Text("Only Favorites products"),
                  value: FilterOption.Favorites,
                )
              ],
              onSelected: (FilterOption selectedValue) {
                setState(() {
                  if (selectedValue == FilterOption.All) {
                    showOnlyFavorite = false;
                  }
                  if (selectedValue == FilterOption.Favorites) {
                    showOnlyFavorite = true;
                  }
                });
              },
            )
          ],
        ),
        body: ProductGrid(showOnlyFavorite));
  }
}
