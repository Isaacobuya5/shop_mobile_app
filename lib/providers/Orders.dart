import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/cart_item.dart';
import '../model/order_item.dart';

class Orders with ChangeNotifier {

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
     final timestamp = DateTime.now();
     // url for the api endpoint
    const url = 'https://shop-mobile-app-3f890.firebaseio.com/orders.json';

    final response = await http.post(url, body: json.encode({
      'amount': total,
      'dateTime': timestamp.toIso8601String(),
      'products': cartProducts.map((cartProduct) => {
        'id': cartProduct.id,
        'title': cartProduct.name,
        'quantity': cartProduct.quantity,
        'price': cartProduct.price
      }).toList()
    }));
    _orders.insert(0, OrderItem(
      id: json.decode(response.body)['name'], 
      amount: total, 
      products: cartProducts, 
      dateTime: DateTime.now()));

      notifyListeners();
  }
}