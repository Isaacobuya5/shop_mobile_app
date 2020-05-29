import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {

static const routeName = '/user-products';
  
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: (){})
        ],),
        body: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, index) => UserProductItem(productData.items[index].title, productData.items[index].imageUrl)
          ),
    );
  }
}