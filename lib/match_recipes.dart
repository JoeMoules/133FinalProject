import 'database_helper.dart';
import 'package:flutter/material.dart';

class MatchRecipes extends StatefulWidget {
  final List<Recipe> suitableRecipes;

  MatchRecipes({required this.suitableRecipes});

  @override
  MatchRecipesState createState() => MatchRecipesState();
}

class MatchRecipesState extends State<MatchRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(backgroundColor:Colors.yellow, title: const Text('Matched Recipe', style: TextStyle(color: Colors.black),)),//appBar
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
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
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      children: const [
                        Text(
                          "Meal Plan",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Print lists, same method to search_recipe
                  GridView.count(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    shrinkWrap: true,
                    children: widget.suitableRecipes.map((recipe) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, "DetailedRecipe", arguments: recipe);
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: const Image(
                                  image: AssetImage("images/1.png"), // Assuming the image name is the id of the recipe
                                  fit: BoxFit.cover,
                                  height: 110,
                                  width: 110,
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    recipe.name,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    recipe.instructions,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}