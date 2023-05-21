import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'cart_model.dart';
import 'package:provider/provider.dart';

class DetailedRecipe extends StatefulWidget {
  final Recipe recipe;

  DetailedRecipe({required this.recipe});

  @override
  DetailedRecipeState createState() => DetailedRecipeState();
}

class DetailedRecipeState extends State<DetailedRecipe>{  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.yellow, title: const Text('Recipe details', style: TextStyle(color: Colors.black),)),//appBar
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //photo of recipe
              Container(
                padding: EdgeInsets.all(15),
                height:350,
                width: double.infinity,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("images/1.png")
                  ),
                ),
              ),
              //description of recipe
              Container(
                //change height according to your choice
                height: MediaQuery.of(context).size.height*0.4,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 15),
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.recipe.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //recipe description field. 
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description: ",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            widget.recipe.instructions,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Add to shopplinglist button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //add to shoppinglist button
                        InkWell(
                          //add ingredients to the _cartItem and go to IngredientsAdded page
                          onTap: () {
                            var cartModel = Provider.of<CartModel>(context, listen: false);
                            var amounts = widget.recipe.ingredientAmount.split(',');
                            for (var i = 0; i < amounts.length; i++) {
                              var amount = int.tryParse(amounts[i]);
                              if (amount != null && amount > 0) {
                                cartModel.addCartItem(CartItem(ingredient: ingredientList[i], count: amount));
                              }
                            }

                            Navigator.pushNamed(context, 'IngredientsAdded',);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Add to Shopping List",
                              style: TextStyle(
                                color: Color.fromARGB(255, 190, 171, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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