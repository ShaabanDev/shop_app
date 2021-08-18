import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/badge.dart';
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
  var initt = true;

  @override
  void initState() {}

  @override
  void didChangeDependencies() {
    if (initt)
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchAndSettProducts();
    super.didChangeDependencies();
  }

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
      body: ProductGrid(showOnlyFavorite),
      drawer: AppDrawer(),
    );
  }
}
