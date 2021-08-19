import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get auth {
    return token != null;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

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
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void logOut() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }
}
