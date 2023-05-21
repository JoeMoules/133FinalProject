import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'auth_page.dart';
import 'signin_register.dart';
import 'widget_tree.dart';
import 'goal_option.dart';
import 'search_recipe.dart';
import 'shopping_list.dart';
import 'detailed_recipe.dart';
import 'add_recipe.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'order_completed.dart';
import 'ingredient_added.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _Goaloption = 'GoalOption';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        routes: {
          'SignIn': (context) => const widgetTree(),
          'Home': (context) => Home(),
          'GoalOption': (context) => const GoalOption(title: _Goaloption),
          'AddRecipe': (context) => const AddRecipe(),
          //'MealPlan':(context)=> MealPlan(),
          'SearchRecipe': (context) => SearchRecipe(),
          'ShoppingList': (context) => ShoppingList(),
          'DetailedPlan': (context) => DetailedPlan(),
          'DatabaseTest': (context) => DatabaseTest(),
          'OrderCompleted': (context) => OrderCompleted(),
          'IngredientsAdded': (context) => IngredientsAdded(),
        },
        onGenerateRoute: (settings) {
          // Check if the route name is DetailedRecipe
          if (settings.name == 'DetailedRecipe') {
            final Recipe recipe = settings.arguments as Recipe;
            return MaterialPageRoute(
                builder: (context) => DetailedRecipe(recipe: recipe));
          }
        },
        initialRoute: 'SignIn',
      ),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
      ), //appBar
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'GoalOption',
                );
              },
              child: const Text('Set Goals'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'AddRecipe',
                );
              },
              child: const Text('Add Recipe'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'SearchRecipe',
                );
              },
              child: const Text('Search Recipes'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'ShoppingList',
                );
              },
              child: const Text('Shopping List'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                signOut();
                Navigator.pushNamed( context, 'SignIn', );
              },
              child: const Text('Sign Out'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class DetailedPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DetailedPlan')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class DatabaseTest extends StatefulWidget {
  @override
  State<DatabaseTest> createState() => DatabaseTestState();
}

class DatabaseTestState extends State<DatabaseTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Database Test')),
      body: Center(
        child: FutureBuilder<List<Recipe>>(
          future: DatabaseHelper.instance.getList(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading...'));
            }
            return snapshot.data!.isEmpty
                ? const Center(child: Text("No Groceries in List."))
                : Center(
                    child: ListView(
                    children: snapshot.data!.map((recipe) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(recipe.name),
                        ),
                      );
                    }).toList(),
                  ));
          },
        ),
      ),
    );
  }
}
