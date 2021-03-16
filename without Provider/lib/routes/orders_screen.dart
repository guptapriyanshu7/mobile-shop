import '../widgets/main_drawer.dart';
import '../widgets/order_item.dart';
import 'package:flutter/material.dart';
import '../models/order.dart';

class OrdersScreen extends StatelessWidget {
  final Order orderData;
  OrdersScreen(this.orderData);
  static const routeName = '/orders_screen';
  @override
  Widget build(BuildContext context) {
    print('orders_screen');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (_, i) => OrderItemWidget(orderData.orders[i]),
      ),
      // body: Text('Hello'),
    );
  }
}
