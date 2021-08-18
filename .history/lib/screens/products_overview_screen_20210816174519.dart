import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum FilterOption { All, Favorites }

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSettProducts()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  bool _isLoading = true;
  bool showOnlyFavorite = false;
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
          ),
          Consumer<Cart>(
            builder: (c, cart, ch) => Badge(
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartSceen.routeName);
                    },
                    icon: Icon(Icons.shopping_cart)),
                value: cart.cartCount.toString()),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(showOnlyFavorite),
      drawer: AppDrawer(),
    );
  }
}
