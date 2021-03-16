import '../models/cart.dart';
import 'package:MyShop/models/order.dart';
// import 'package:MyShop/models/order.dart';
import 'package:MyShop/widgets/badge.dart';
import 'package:MyShop/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/products_grid.dart';
import './cart_screen.dart';

enum FilterOptions { Favorites, All }

class ProductsScreen extends StatefulWidget {
  final List<Product> _products;
  final Cart cart;
  final Order order;
  ProductsScreen(this._products, this.cart, this.order);
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // final Cart cart = Cart();
  // final Order order = Order();
  // final List<Product> _products =

  var _showOnlyFavorites = false;
  void change() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('products_screen');
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          PopupMenuButton(
            onSelected: (value) => setState(() {
              if (value == FilterOptions.Favorites) {
                _showOnlyFavorites = true;
              } else {
                _showOnlyFavorites = false;
              }
            }),
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Badge(
            value: widget.cart.itemCount.toString(),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                    // MaterialPageRoute(
                    //   builder: (BuildContext context) =>
                    //       CartScreen(widget.cart, widget.order)))
                    CartScreen.routeName).then((_) => setState(() {
                      _showOnlyFavorites = false;
                    }));
              },
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: ProductsGrid(
          widget._products, _showOnlyFavorites, widget.cart, change),
    );
  }
}
