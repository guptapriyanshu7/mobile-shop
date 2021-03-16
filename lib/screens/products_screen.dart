import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

import '../screens/cart_screen.dart';

import '../widgets/badge.dart';
import '../widgets/main_drawer.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
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
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () async {
                final response =
                    await Navigator.of(context).pushNamed(CartScreen.routeName);
                print(response);
                setState(() {
                  _showOnlyFavorites = false;
                });
              },
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
