import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/order.dart';
import '../models/cart.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get orders {
    return [..._orders];
  }

  final String authToken;
  final String userId;

  OrdersProvider(
    this._orders, {
    this.authToken,
    this.userId,
  });

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://flutter-a7cb2.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final List<Order> loadedOrders = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        _orders = [];
        return;
      }
      extractedData.forEach(
        (orderId, orderData) {
          loadedOrders.add(
            Order(
              id: orderId,
              amount: double.parse(orderData['amount']),
              dateTime: DateTime.parse(orderData['dateTime']),
              products: (orderData['products'].values.toList() as List<dynamic>)
                  .map((product) => Cart(
                        id: product['id'],
                        price: product['price'],
                        quantity: product['quantity'],
                        title: product['title'],
                      ))
                  .toList(),
            ),
          );
        },
      );

      _orders = loadedOrders.reversed.toList();
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<void> addOrder(Map<String, Cart> cartProducts, double total) async {
    final url =
        'https://flutter-a7cb2.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();
    // Map<String, Cart> cart = {};
    // for (int i = 0; i < cartProducts.length; i += 1) {
    //   cart.putIfAbsent(
    //     'product ${i + 1}',
    //     () => Cart(
    //       id: cartProducts[i].id,
    //       price: cartProducts[i].price,
    //       quantity: cartProducts[i].quantity,
    //       title: cartProducts[i].title,
    //     ),
    //   );
    // }

    final response = await http.post(
      url,
      body: json.encode({
        'amount': total.toStringAsFixed(2),
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts.map(
          (key, product) => MapEntry(key, {
            'id': product.id,
            'price': product.price,
            'quantity': product.quantity,
            'title': product.title,
          }),
        )
        // 'products': cartProducts
        //     .map((product) => {
        //           'id': product.id,
        //           'price': product.price,
        //           'quantity': product.quantity,
        //           'title': product.title,
        //         })
        //     .toList(),
      }),
    );
    _orders.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts.values.toList(),
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
