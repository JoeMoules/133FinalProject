import 'database_helper.dart';
import 'package:flutter/material.dart';

class SearchRecipe extends StatefulWidget {
  @override
  SearchRecipeState createState() => SearchRecipeState();
}

class SearchRecipeState extends State<SearchRecipe>{
  late List<Recipe> recipes;

  Future<List<Recipe>> fetchRecipes() async {
    recipes = await DatabaseHelper.instance.getList();
    return recipes;
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.yellow, title: const Text('Search Recipes', style: TextStyle(color: Colors.black),)),//appBar
      body: SingleChildScrollView(
        child: Column(
          children: [
            // //search bar
            // Container(
            //   margin: EdgeInsets.all(15),
            //   padding: EdgeInsets.symmetric(horizontal: 15),
            //   height: 50,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(20),
            //     ),
            //   child: Row (
            //     children: [
            //       Icon(Icons.search),
            //       Container(
            //         margin: EdgeInsets.only(left: 10),
            //         width: 250,
            //         child: TextFormField(decoration: InputDecoration(
            //           hintText: "Search here ...",
            //           border: InputBorder.none,
            //         ),
            //         ),
            //       ),
            //       Spacer(),
            //       Icon(Icons.filter_list),
            //       ],
            //   ),
            // ),
            Container(
              padding:const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                  topLeft:Radius.circular(30),
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
                          "Recipes",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //show list of recipes
                FutureBuilder<List<Recipe>>(
                  future: fetchRecipes(),
                  builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return GridView.count(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        shrinkWrap: true,
                        children: snapshot.data!.map((recipe) {
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
                                    margin: const EdgeInsets.all(10),
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
                        );
                      }
                    },
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