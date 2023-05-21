import 'package:flutter/foundation.dart';
import 'database_helper.dart';

class CartModel extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;
  //add items in cart
  void addCartItem(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }
  //remove items in cart
  void removeCartItem(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }
  //increment number of items in the cart
  void incrementItem(CartItem item) {
    int index = _cartItems.indexOf(item);
    _cartItems[index].count++;
    notifyListeners();
  }
  //decrement number of items in the cart
  void decrementItem(CartItem item) {
    int index = _cartItems.indexOf(item);
    if (_cartItems[index].count > 0) {
      _cartItems[index].count--;
      notifyListeners();
    }
  }
  //remove every itmes in cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}