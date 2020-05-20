import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../screens/ProductDetails.dart';

class ProductItem extends StatelessWidget {

  // final String id;
  // final String title;
  // final String imageUrl;

  ProductItem();

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),  
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(ProductDetail.routeName, arguments: product.id),
          child: GridTile(
          child: Image.network(product.imageUrl, fit: BoxFit.cover,),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_border), 
              onPressed: () => product.toggleFavouriteStatus(),
              color: Theme.of(context).accentColor,
              ),
            title: Text(product.title, textAlign: TextAlign.center),
            trailing: IconButton(icon: Icon(Icons.shopping_cart), 
            onPressed: (){},
            color: Theme.of(context).accentColor,),),
          ),
        ),
    );
  }
}