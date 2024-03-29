import 'dart:convert';

import 'package:flutter/material.dart';
import './cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;
  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://meal-app2022-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final exstractedData = json.decode(response.body) as Map<String, dynamic>;
    if (exstractedData == null) {
      return;
    }
    exstractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['product'] as List<dynamic>)
              .map((item) => CartItem(
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price'],
                  id: item['id']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime'])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://meal-app2022-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timesamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timesamp.toIso8601String(),
        'product': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timesamp,
        products: cartProducts,
      ),
    );

    notifyListeners();
  }
}
