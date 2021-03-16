import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';
import './providers/products_provider.dart';

import 'helpers/custom_page_transition.dart';

import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/auth_screen.dart';
import './screens/products_screen.dart';
import './screens/product_details_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

void main() => runApp(MyShop());

class MyShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (_) => ProductsProvider([]),
          update: (_, auth, previousProducts) => ProductsProvider(
            // previousProducts == null ? [] :
            previousProducts.items,
            authToken: auth.token,
            userId: auth.userId,
          ),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProxyProvider<Auth, OrdersProvider>(
          create: (_) => OrdersProvider([]),
          update: (_, auth, previousOrders) => OrdersProvider(
            // previousOrders == null ? [] :
            previousOrders.orders,
            authToken: auth.token,
            userId: auth.userId,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.orange,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(headline4: TextStyle(color: Colors.amber)),
          ),
          home: auth.isAuth
              ? ProductsScreen()
              : FutureBuilder(
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Scaffold(
                              body: Center(
                                child: Text('Loading...'),
                              ),
                            )
                          : AuthScreen(),
                  future: auth.tryAutoLogin(),
                ),
          routes: {
            ProductDetailsScreen.routeName: (_) => ProductDetailsScreen(),
            CartScreen.routeName: (_) => CartScreen(),
            OrdersScreen.routeName: (_) => OrdersScreen(),
            UserProductsScreen.routeName: (_) => UserProductsScreen(),
            EditProductScreen.routeName: (_) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
