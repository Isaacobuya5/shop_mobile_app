import 'package:flutter/foundation.dart';

import '../model/cart_item.dart';

class Cart with ChangeNotifier {

// a map of cart items
  Map<String, CartItem> _items = {};

// getter for the cart items
Map<String, CartItem> get items {
  return {..._items};
}

// number of items in cart
int get itemCount {
  return _items.length;
}

//calculate total amount of cart items
double get totalAmount {
  var total = 0.0;
  _items.forEach((key, cartItem) => {
    total += cartItem.price * cartItem.quantity
  });
  return total;
}

// adding a new cart item
void addItem(String productId, double price, String title) {
  // if a product already exists in cart, then change quantity
  if (_items.containsKey(productId)) {
    // change quantity
    _items.update(productId, (existingCartItem) => CartItem(
      id: existingCartItem.id, 
      name: existingCartItem.name, 
      quantity: existingCartItem.quantity + 1, 
      price: existingCartItem.price
      ));
  } else {
    _items.putIfAbsent(productId, () => CartItem(
      id: DateTime.now().toString(), 
      name: title, 
      quantity: 1, 
      price: price
      ));
  }
  notifyListeners();
}

// removing an item
void removeItem(String productId) {
  _items.remove(productId);
  notifyListeners();
}

// clear cart
void clearCart() {
  _items = {};
  notifyListeners();
}

// undo add item action
void removeSingleItem(productId) {
  // if no such item exists simply return
  if (!_items.containsKey(productId)) {
    return;
  }
  // if item already exists in the cart then decrease the quantity
  if (_items[productId].quantity > 1) {
    _items.update(productId, (existingProduct) => CartItem(
      id: existingProduct.id,
      name: existingProduct.name,
      price: existingProduct.price,
      quantity: existingProduct.quantity - 1));
  } else {
    // remove the product from the cart
    _items.remove(productId);
  }
  // call notifyListeners to effect changes in all connected widgets
  notifyListeners();
}
}