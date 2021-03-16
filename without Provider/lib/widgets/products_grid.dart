import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/cart.dart';
import '../routes/product_detail.dart';

class ProductsGrid extends StatefulWidget {
  final List<Product> products;
  final bool onlyFav;
  final Cart cart;
  final Function change;

  ProductsGrid(
    this.products,
    this.onlyFav,
    this.cart,
    this.change,
  );
  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  bool cartStatus(p) {
    if (widget.cart.items.containsKey(p)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print('products_grid');
    List<Product> displayProducts = widget.onlyFav
        ? widget.products
            .where((element) => element.isFavorite == true)
            .toList()
        : widget.products;

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
                ProductDetail.routeName,
                arguments: displayProducts[index],
              );
            },
            child: Image.network(
              displayProducts[index].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              icon: Icon(displayProducts[index].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_outline),
              onPressed: () {
                setState(() {
                  displayProducts[index].toggleFavoriteStatus();
                });
              },
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              displayProducts[index].title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(
                cartStatus(displayProducts[index].id)
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
              ),
              onPressed: () {
                widget.cart.addItem(displayProducts[index].id,
                    displayProducts[index].price, displayProducts[index].title);
                cartStatus(displayProducts[index].id);
                widget.change();
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
      itemCount: displayProducts.length,
    );
  }
}
