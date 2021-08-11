import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_grid.dart';

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
                itemBuilder: (_) => [
                      PopupMenuItem(
                          child: Text("All Products"), value: FilterOption.All),
                      PopupMenuItem(
                        child: Text("Only Favorites products"),
                        value: FilterOption.Favorites,
                      )
                    ])
          ],
        ),
        body: ProductGrid());
  }
}
