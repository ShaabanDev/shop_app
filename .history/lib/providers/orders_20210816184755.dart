import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    final stamp = DateTime.now();
    var url =
        Uri.parse("https://shop-7b8f0-default-rtdb.firebaseio.com/orders.json");
    http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': stamp.toIso8601String(),
          'products': cartProducts
              .map((cartItem) => {
                    'id': cartItem.id,
                    'title': cartItem.title,
                    'price': cartItem.price,
                    'quantity': cartItem.quantity
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          dateTime: DateTime.now(),
          amount: total,
          products: cartProducts,
        ));
    notifyListeners();
  }
}
