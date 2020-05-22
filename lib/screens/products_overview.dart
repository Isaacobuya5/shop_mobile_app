import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
// import '../providers/products.dart';

enum FilterOptions {
  Favorites,
  All
}

class ProductsOverview extends StatefulWidget {

  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {

  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {

    // final productContainer = Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {

              setState(() {
            if (selectedValue == FilterOptions.Favorites) {
               _showFavorites = true;
              } else {
                _showFavorites = false;
              }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text("Only favourites"), value: FilterOptions.Favorites),
              PopupMenuItem(child: Text("All items"), value: FilterOptions.All)
            ])
        ],
      ),
      body: ProductsGrid(_showFavorites),
    );
  }
}

