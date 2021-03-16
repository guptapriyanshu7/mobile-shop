import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';

import '../widgets/main_drawer.dart';
import '../widgets/order_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders_screen';

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<OrdersProvider>(context, listen: false).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context, listen: false)
            .fetchAndSetOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<OrdersProvider>(
                builder: (ctx, orderData, child) => (orderData.orders.length ==
                        0)
                    ? Center(child: Text('No Orders yet!'))
                    : ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (_, i) => OrderWidget(orderData.orders[i]),
                      ),
              );
            }
          }
        },
      ),
    );
  }
}
