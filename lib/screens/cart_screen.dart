import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';

import '../widgets/cart_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart_screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop('Hey');
            },
          ),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Total', style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Chip(
                      label: Text(
                        'Rs. ${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    OrderButton(cart),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartWidget(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title,
                ),
              ),
            ),
          ],
        ));
  }
}

class OrderButton extends StatefulWidget {
  final CartProvider cart;
  const OrderButton(this.cart);
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cart.totalAmount == 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              if (widget.cart.items.isNotEmpty) {
                await Provider.of<OrdersProvider>(context, listen: false)
                    .addOrder(
                  widget.cart.items,
                  widget.cart.totalAmount,
                );
                setState(() {
                  _isLoading = false;
                });
                widget.cart.clear();
              }
            },
      child: _isLoading ? CircularProgressIndicator() : Text('Order Now'),
      textColor: Theme.of(context).primaryColor,
    );
  }
}
