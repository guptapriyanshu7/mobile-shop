import '../models/cart.dart';
import '../models/order.dart';
import '../widgets/cart_item.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart_screen';
  final Cart cart;
  final Order order;
  CartScreen(this.cart, this.order);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void change() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('cart_screen');
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Chip(
                      label: Text(
                        '${widget.cart.totalAmount}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      onPressed: () {
                        widget.order.addOrder(
                          widget.cart.items.values.toList(),
                          widget.cart.totalAmount,
                        );
                        widget.cart.clear();
                        change();
                      },
                      child: Text('Order Now'),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cart.items.length,
                itemBuilder: (ctx, i) => CartItemWidget(
                  widget.cart.items.values.toList()[i].id,
                  widget.cart.items.keys.toList()[i],
                  widget.cart.items.values.toList()[i].price,
                  widget.cart.items.values.toList()[i].quantity,
                  widget.cart.items.values.toList()[i].title,
                  widget.cart,
                  change,
                ),
              ),
            ),
          ],
        ));
  }
}
