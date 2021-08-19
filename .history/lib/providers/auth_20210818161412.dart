import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signUp(String? email, String? password) async {
    return _sign(email, password, 'signUp');
  }

  Future<void> loggIn(String? email, String? password) async {
    return _sign(email, password, 'signInWithPassword');
  }

  Future<void> _sign(String? email, String? password, String signType) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$signType?key=AIzaSyDyeaS7DYfHNnQvQDd97U_7ZwZEXP-6ScQ");

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      if (json.decode(response.body)['error'] != null) {
        throw HttpException(json.decode(response.body)['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}
