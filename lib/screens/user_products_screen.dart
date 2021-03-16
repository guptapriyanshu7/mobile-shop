import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

import '../screens/edit_product_screen.dart';

import '../widgets/main_drawer.dart';
import '../widgets/user_product_widget.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user_products_screen';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
                arguments: {'id': null, 'title': 'Add Product'},
              );
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<ProductsProvider>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              UserProductWidget(
                                productsData.items[i].id,
                                productsData.items[i].title,
                                productsData.items[i].imageUrl,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
