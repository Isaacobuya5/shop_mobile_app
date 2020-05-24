import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import './screens/products_overview.dart';
import './screens/ProductDetails.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // registering ProductsProvider class as a Provider
    return MultiProvider(
      providers: [
         ChangeNotifierProvider.value(
          value: ProductsProvider(),
         ),
         ChangeNotifierProvider.value(
          value: Cart(),
         )
      ],
        child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
        home: ProductsOverview(),
        routes: {
          ProductDetail.routeName: (context) => ProductDetail()
        },
      ),
    );
  }
}


class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text("My shop mobile application"),
      )
    );
  }
}
