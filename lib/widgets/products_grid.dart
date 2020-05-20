import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import '../model/product.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key key,
    @required this.loadedProducts,
  }) : super(key: key);

  final List<Product> loadedProducts;

  @override
  Widget build(BuildContext context) {
    // set up listener for the ProductsProvider
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
        ), 
      itemBuilder: (context, index) =>ProductItem(
        products[index].id, 
        products[index].title, 
        products[index].imageUrl)
      );
  }
}