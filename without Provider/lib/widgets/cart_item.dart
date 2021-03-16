import '../models/cart.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final Cart cart;
  final Function change;

  CartItemWidget(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.cart,
    this.change
  );

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    print('cart_item_widget');
    return Dismissible(
      key: ValueKey(widget.id),
      onDismissed: (_) {
        // setState(() {
          widget.cart.removeItem(widget.productId);
          widget.change();
        // });
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${widget.price}')),
          title: Text(widget.title),
          subtitle: Text(
              'Total: \$${(widget.price * widget.quantity).toStringAsFixed(2)}'),
          trailing: Text('${widget.quantity} x'),
        ),
      ),
    );
  }
}
