import 'package:flutter/material.dart';

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
        appBar: AppBar(actions: [
          PopupMenuButton(itemBuilder: (_)=>[
            PopupMenuItem(child: Text("All Products"),value:)
          ])
        ],),
        body: ProductGrid());
  }
}
