import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    // id for this particular product
    final productId = ModalRoute.of(context).settings.arguments as String;
    // retrieve value for this particular product
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}