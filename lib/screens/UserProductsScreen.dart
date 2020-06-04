import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/AppDrawer.dart';
import './EditProductScreen.dart';

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
            onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            })
        ],),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, index) => Column(
            children: <Widget>[
              UserProductItem(productData.items[index].id,productData.items[index].title, productData.items[index].imageUrl),
              Divider()
            ],
          )
          ),
    );
  }
}