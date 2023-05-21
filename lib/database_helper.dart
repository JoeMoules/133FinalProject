import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<Ingredient> ingredientList = [
  Ingredient(name: '1oz of Beef', calories: 65),
  Ingredient(name: '1oz of Chicken', calories: 30),
  Ingredient(name: '1 Egg', calories: 75),
  Ingredient(name: '1oz of Tofu', calories: 95),
  Ingredient(name: 'slice of bread', calories: 100),
  Ingredient(name: 'Cup of Rice', calories: 205),
  Ingredient(name: 'Cup of Milk', calories: 100),
  Ingredient(name: 'Cup of Cereal', calories: 300),
];
Recipe steakAndEgg = Recipe(name: 'Steak and Egg', ingredientAmount: '6,0,2,0,0,0,0,0', instructions:'Cook steak to desired temperature, fry eggs in the pan after removing steak, plate and enjoy', isVegetarian: false, allergies: ['Egg']);
Recipe chickenAndRice = Recipe(name: 'Chicken and Rice', ingredientAmount: '0,6,0,0,0,2,0,0', instructions: 'Thoroughly cook chicken while boiling rice, plate chicken over rice', isVegetarian: false, allergies: []);
Recipe omelette = Recipe(name: 'Omelette', ingredientAmount: '0,0,3,1,0,0,0,0', instructions: 'Crack eggs and whisk in bowl, pour eggs into hot pan, once egg begins to solidify flip over and sprinkle cheese, fold egg and enjoy',isVegetarian: false, allergies: ['Egg']);
Recipe tofuFriedRice = Recipe(name: 'Tofu Fried Rice', ingredientAmount: '0,0,0,4,0,2,0,0', instructions: 'Fry tofu first and then add steamed rice to the pan. Stir fried for 10 mins in strong heat',isVegetarian: true, allergies: []);
Recipe friedChicken = Recipe(name: 'Cereal Breaded Chicken', ingredientAmount: '0,6,1,0,0,0,0,1', instructions: 'Crush cereal and put whisked egg into a bowl, submerge the chicken into the egg before covering it with the crushed cereal, fry the chicken',isVegetarian: false, allergies: ['Egg']);
Recipe dairyDelight = Recipe(name: 'DairyDelight', ingredientAmount: '0,0,0,0,0,0,5,1', instructions: 'Pour it in a bowl and scoop',isVegetarian: false, allergies: ['Milk']);

class Recipe {
  final int? id;
  final String name;
  final String ingredientAmount;
  final String instructions;
  final bool isVegetarian;
  final List<String> allergies;

  Recipe({this.id, required this.name, required this.ingredientAmount, required this.instructions, required this.isVegetarian, required this.allergies});

  factory Recipe.fromMap(Map<String, dynamic> json) => Recipe(
    id: json['id'],
    name: json['name'],
    ingredientAmount: json['ingredientAmount'],
    instructions: json['instructions'],
    isVegetarian: json['isVegetarian'] == 1 ? true : false,
    allergies: json['allergies'] != null ? json['allergies'].split(',').toList() : [],
  );

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'name' : name,
      'ingredientAmount' : ingredientAmount,
      'instructions' : instructions,
      'isVegetarian' : isVegetarian ? 1 : 0,
      'allergies' : allergies.join(','),
    };
  }
  //calculate calories of recipes
  int calculateCalories(List<Ingredient> ingredientList) {
    List<int> amounts = ingredientAmount.split(',').map(int.parse).toList();
    int totalCalories = 0;
    for (int i = 0; i < ingredientList.length; i++) {
      int amount = amounts[i];
      int calories = ingredientList[i].calories;
      totalCalories += amount * calories;
    }
    return totalCalories;
  }

  @override
  String toString(){
    return '$id $name $ingredientAmount';
  }
}

class Ingredient {
  String name;
  int calories;
  Ingredient({required this.name, required this.calories});
}

class CartItem {
  Ingredient ingredient;
  int count;
  CartItem({required this.ingredient, required this.count});
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ingredients.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,

    );
  }
  Future _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE list(
      id INTEGER PRIMARY KEY,
      name TEXT,
      ingredientAmount TEXT,
      instructions TEXT,
      isVegetarian INTEGER,
      allergies TEXT
      )
    ''');
    await db.insert('list', steakAndEgg.toMap());
    await db.insert('list', chickenAndRice.toMap());
    await db.insert('list', omelette.toMap());
    await db.insert('list', tofuFriedRice.toMap());
    await db.insert('list', friedChicken.toMap());
    await db.insert('list', dairyDelight.toMap());
  }
  //add restrictions to database
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    await db.execute('''
    ALTER TABLE list
    ADD isVegetarian INTEGER NOT NULL DEFAULT 0
    ''');
    await db.execute('''
    ALTER TABLE list
    ADD allergies TEXT
    ''');
  }
}
  Future<List<Recipe>> getList () async {
    Database db = await instance.database;
    var list = await db.query('list');
    List<Recipe> stringList = list.isNotEmpty
        ? list.map((c) => Recipe.fromMap(c)).toList()
        : [];
    return stringList;
  }
  Future<int> add(Recipe obj) async{
    Database db = await instance.database;
    return await db.insert('list', obj.toMap());
  }
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('list', where: 'id = ?', whereArgs: [id]);
  }
  Future<int> update(Recipe obj) async{
    Database db = await instance.database;
    return await db.update('list', obj.toMap(),
        where: "id = ?", whereArgs: [obj.id]);
  }

  //filter recipes with user's restrictions
  Future<List<Recipe>> getFilteredRecipes(bool isVegetarian, List<String> allergies, int calorieGoal) async {
    List<Recipe> allRecipes = await getList();
    List<Recipe> filteredRecipes = [];

    for (Recipe recipe in allRecipes) {
      if (recipe.isVegetarian == isVegetarian) {
        bool match = true;
        for (String allergy in allergies) {
          if (recipe.allergies.contains(allergy)) {
            match = false;
            break;
          }
        }
        if (match) {
          int recipeCalories = recipe.calculateCalories(ingredientList);
          if (recipeCalories <= calorieGoal) {
            filteredRecipes.add(recipe);
          }
        }
      }
    }

    return filteredRecipes;
  }
}