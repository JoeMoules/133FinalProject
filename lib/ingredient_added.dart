import 'database_helper.dart';
import 'package:flutter/material.dart';

class IngredientsAdded extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(backgroundColor:Colors.yellow, title: const Text('Ingredients added', style: TextStyle(color: Colors.black),)),//appBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Ingredients \nAdded!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            //navigate users to SearchRecipe page
            const SizedBox(height: 100),  // SizedBox
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black, 
                onPrimary: Colors.yellow, 
              ),
              onPressed:() {
                Navigator.pop(context);
              },
              child: const Text('Continue Shopping'),
            ),
            //navigate users to Shoppling list page
            const SizedBox(height: 10),  // SizedBox
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black, 
                onPrimary: Colors.yellow, 
              ),
              onPressed:() {
                Navigator.pushNamed(context, 'ShoppingList',);
              },
              child: const Text('Proceed to checkout'),
            ),
          ],
        ),
      ),
    );
  }
}