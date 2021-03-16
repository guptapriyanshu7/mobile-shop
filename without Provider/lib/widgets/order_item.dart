import 'dart:math';

import 'package:MyShop/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemWidget extends StatefulWidget {
  final Order order;

  OrderItemWidget(this.order);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    print('order_item');
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Rs. ${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: () => setState(() {
                _expanded = !_expanded;
              }),
            ),
          ),
          if (_expanded)
            Container(
                height: min(widget.order.products.length * 20.0, 100),
                child: ListView(
                  children: widget.order.products
                      .map((product) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(product.title),
                              Text('${product.quantity}x Rs. ${product.price}'),
                            ],
                          ))
                      .toList(),
                ))
        ],
      ),
    );
  }
}
