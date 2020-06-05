import 'package:flutter/foundation.dart';

import './product.dart';

class ProductsProvider with ChangeNotifier {

  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var _showFavoritesOnly = false;

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  // method to get list of products
  List<Product> get items {

    // if (_showFavoritesOnly) {
    //   return _items.where((product) => product.isFavourite == true).toList();
    // } else {
    // we need to return a copy of items and not the actual reference
    return [..._items];
    // }
  }

  // method to return a list of only favourite products
  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavourite).toList();
  }

  // method to find a product by id
  Product findById(id) {
    return _items.firstWhere((product) => product.id == id);
  }

  // method to add a new product
  void addNewProduct(Product product) {

    final newProduct = Product(
      id: DateTime.now().toString(), 
      title: product.title, 
      description: product.description, 
      price: product.price, 
      imageUrl: product.imageUrl);

      // adding a product to the list
      _items.add(newProduct);
      // we could add a product at the beggining of the list this way
      // _items.insert(0, newProduct);
    // _items.add(value);
    // we need to notify other listeners of the update
    notifyListeners();
  }

  // method to edit an existing product
  void editProduct(String productId,Product newProduct) {
    // get the index for the product
    final productIndex = _items.indexWhere((product) => product.id == productId);
    // just checking if an index was found
    if (productIndex >= 0) {
      // update the product at that index with the new product
      _items[productIndex] = newProduct;
      // notify listeners connected to this
      notifyListeners();
    } else {
      print('update failed');
    }
  }

  // method to delete a product
  void deleteProduct(String id) {
    // delete a product with the given id
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}