import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product_details_screen';
  @override
  Widget build(BuildContext context) {
    final loadedProduct = ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            // title: Text(loadedProduct.title),
            background: Hero(
              tag: loadedProduct.id,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10),
            Text(
              loadedProduct.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Rs. ${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(height: 800),
          ]),
        ),
      ]),
    );
  }
}
