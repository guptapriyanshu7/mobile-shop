import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartWidget extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartWidget(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => Provider.of<CartProvider>(context, listen: false)
          .removeItem(productId),
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the item from the cart?'),
            actions: [
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Padding(
              padding: EdgeInsets.all(2),
              child: FittedBox(
                child: Text('Rs. $price'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: Rs. ${(price * quantity).toStringAsFixed(2)}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
