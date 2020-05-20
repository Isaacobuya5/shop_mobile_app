import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetail extends StatelessWidget {

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    // id for this particular product
    final productId = ModalRoute.of(context).settings.arguments as String;
    // retrieve value for this particular product
    final loadedProduct = Provider.of<ProductsProvider>(context).items.firstWhere((product) => product.id == productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}