import 'package:MyShop/models/cart.dart';
import 'package:MyShop/models/order.dart';
import './models/product.dart';
import './routes/cart_screen.dart';
import './routes/orders_screen.dart';
import 'package:flutter/material.dart';
import './routes/products_screen.dart';
import './routes/product_detail.dart';
// import 'package:MyShop/routes/orders_screen.dart';
// import '../lib(without Provider)/models/cart.dart';
// import './routes/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Cart cart = Cart();
  final Order order = Order();
  final List<Product> _products = [
    Product(
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
    ),
  ];
  @override
  Widget build(BuildContext context) {
    print('main');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(headline4: TextStyle(color: Colors.amber)),
      ),
      home: ProductsScreen(_products, cart, order),
      routes: {
        ProductDetail.routeName: (_) => ProductDetail(),
        CartScreen.routeName: (_) => CartScreen(cart, order),
        OrdersScreen.routeName: (_) => OrdersScreen(order),
      },
    );
  }
}
