import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../screens/ProductDetails.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {

  // final String id;
  // final String title;
  // final String imageUrl;

  ProductItem();

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),  
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(ProductDetail.routeName, arguments: product.id),
          child: GridTile(
          child: Image.network(product.imageUrl, fit: BoxFit.cover,),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (context, product, child) => IconButton(
                icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_border), 
                onPressed: () => product.toggleFavouriteStatus(),
                color: Theme.of(context).accentColor,
                ),
                ),
            title: Text(product.title, textAlign: TextAlign.center),
            trailing: IconButton(icon: Icon(Icons.shopping_cart), 
            onPressed: (){
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Added item to the cart',
                textAlign: TextAlign.center,),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                label: 'UNDO', 
                onPressed: (){
                  cart.removeSingleItem(product.id);
                }),),
              );
            },
            color: Theme.of(context).accentColor,),),
          ),
        ),
    );
  }
}