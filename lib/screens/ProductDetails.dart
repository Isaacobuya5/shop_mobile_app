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
    // we don't want to rebuild this widget if a new product is added
    // for this case and cases where we just need to read data once from provider
    // we need to set listen to false
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}