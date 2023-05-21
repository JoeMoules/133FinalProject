import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'cart_model.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatefulWidget {
  @override
  ShoppingListState createState() => ShoppingListState();
}

var totalCalories = 0;

class ShoppingListState extends State<ShoppingList>{
  List<CartItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    var cartModel = Provider.of<CartModel>(context, listen: false);
    _cartItems = cartModel.cartItems;
    for(var obj in _cartItems){
      totalCalories += obj.ingredient.calories * obj.count;
    }
  }

  @override
  Widget build(BuildContext context) {
    var cartModel = Provider.of<CartModel>(context);

    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(backgroundColor:Colors.yellow, title: const Text('Shopping List', style: TextStyle(color: Colors.black),)),//appBar
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                height: 600,
                child: SingleChildScrollView(
                  child: Column(
                    children: _cartItems.map((cartItem) {
                      var index = _cartItems.indexOf(cartItem) + 1;
                      var count = cartItem.count;
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        //image of items
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                "images/1.png",
                                height: 65,
                                width: 65,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //print title of each item.
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    cartItem.ingredient.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                //print total calories.
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Total Calories: ${cartItem.ingredient.calories * count}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            //increment, decrement and remove buttons
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  //icon that remove corresponding item from cart
                                  IconButton(
                                    alignment: Alignment.topRight,
                                    onPressed: () => cartModel.removeCartItem(cartItem),
                                    icon: const Icon(Icons.delete),
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      //minus button
                                      InkWell(
                                        onTap: () {
                                          cartModel.decrementItem(cartItem);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 8,
                                              ),
                                            ],
                                          ),
                                          child: const Icon(Icons.remove),
                                        ),
                                      ),
                                      //print count
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          '${cartItem.count}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      //plus button
                                      InkWell(
                                        onTap: () {
                                          cartModel.incrementItem(cartItem);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 8,
                                              ),
                                            ],
                                          ),
                                          child: const Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              //white box that holds checkout button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 8,
                    ),
                  ],
                ),
                //checkout box
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Total Calories: $totalCalories",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //checkout button
                    InkWell(
                      //when user click 'checkout' button, it removes everything in cart and go to 'OrderCompleted page
                      onTap: () {
                        cartModel.clearCart();
                        Navigator.pushNamed(context, 'OrderCompleted',);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "Check Out",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}