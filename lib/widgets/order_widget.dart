import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  OrderWidget(this.order);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('Rs. ${widget.order.amount.toStringAsFixed(2)}'),
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
          AnimatedContainer(
              curve: Curves.easeInSine,
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded
                  ? min(widget.order.products.length * 20.0 + 70, 100)
                  : 0,
              child: ListView(
                children: widget.order.products
                    .map((product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              child: Text(
                              '*' + product.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                            Container(
                              width: 80,
                              child: Text(
                              '${product.quantity}x Rs. ${product.price}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            )),
                          ],
                        ))
                    .toList(),
              ))
        ],
      ),
    );
  }
}
