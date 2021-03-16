import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../providers/auth.dart';

import '../screens/product_details_screen.dart';

class ProductsGrid extends StatelessWidget {
  final bool onlyFav;

  ProductsGrid(this.onlyFav);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    final authData = Provider.of<Auth>(context, listen: false);
    List<Product> displayProducts =
        onlyFav ? products.favoriteItems : products.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemBuilder: (ctx, index) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailsScreen.routeName,
                arguments: displayProducts[index],
              );
            },
            child: Hero(
              tag: displayProducts[index].id,
              child: FadeInImage(
                placeholder:
                    AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(displayProducts[index].imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<ProductsProvider>(
              builder: (ctx, products, _) => IconButton(
                icon: Icon(displayProducts[index].isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline),
                onPressed: () => products.toggleFavoriteStatus(
                  displayProducts[index].id,
                  authData.token,
                  authData.userId,
                ),
                color: Theme.of(context).accentColor,
              ),
            ),
            title: Text(
              displayProducts[index].title,
              textAlign: TextAlign.center,
            ),
            trailing: Consumer<CartProvider>(
              builder: (ctx, cart, _) => IconButton(
                icon: Icon(
                  cart.items.containsKey(displayProducts[index].id)
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                ),
                onPressed: () {
                  cart.addItem(
                    displayProducts[index].id,
                    displayProducts[index].price,
                    displayProducts[index].title,
                  );
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to Cart!'),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () => cart.undo(displayProducts[index].id),
                      ),
                    ),
                  );
                },
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
      itemCount: displayProducts.length,
    );
  }
}
