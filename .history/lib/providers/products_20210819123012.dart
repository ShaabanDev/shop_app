import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  final String? token;
  final String? userId;

  ProductsProvider(this.userId, this.token, this._items);

  List<Product> _items = [
    /* Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ), */
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  Future<void> deleteProductItem(String productId) async {
    var url = Uri.parse(
        "https://shop-7b8f0-default-rtdb.firebaseio.com/products/$productId.json?auth=$token");

    final porductIndex =
        _items.indexWhere((element) => element.id == productId);
    var existingProduct = _items[porductIndex];
    _items.removeAt(porductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(porductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    //existingProduct.dispose();
  }

  Future<void> fetchAndSettProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.https('flutter-update.firebaseio.com',
        '/products.json?auth=$token&$filterString');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) return;
      url = Uri.parse(
          "https://shop-7b8f0-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$token");
      final favoritesResponse = await http.get(url);
      final favoritesData = json.decode(favoritesResponse.body);
      final List<Product> loadedProducts = [];

      extractedData.forEach((prodId, value) {
        loadedProducts.add(Product(
            id: prodId,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isFavorite: favoritesData == null
                ? false
                : favoritesData[prodId] ?? false));
      });
      _items = loadedProducts.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(
        "https://shop-7b8f0-default-rtdb.firebaseio.com/products.json?auth=$token");
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId
          }));

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final productIndex = _items.indexWhere((element) => element.id == id);

    if (productIndex >= 0) {
      var url = Uri.parse(
          "https://shop-7b8f0-default-rtdb.firebaseio.com/products/$id.json?auth=$token");
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
      _items[productIndex] = product;
    }
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
