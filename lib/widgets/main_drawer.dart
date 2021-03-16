import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              if (ModalRoute.of(context).settings.name == '/')
                Navigator.of(context).pop();
              else
                Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              if (ModalRoute.of(context).settings.name ==
                  OrdersScreen.routeName)
                Navigator.of(context).pop();
              else
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              if (ModalRoute.of(context).settings.name ==
                  UserProductsScreen.routeName)
                Navigator.of(context).pop();
              else
                Navigator.of(context)
                    .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
