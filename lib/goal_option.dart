import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'match_recipes.dart';

const List<String> vegetarianOptions = ['Yes', 'No'];
const List<String> allergyNames = [
  'Peanut',
  'Wheat',
  'Egg',
  'Milk',
  'Shellfish'
];

class GoalOption extends StatefulWidget {
  const GoalOption({super.key, required this.title});
  final String title;

  @override
  State<GoalOption> createState() => GoalOptionState();
}

class GoalOptionState extends State<GoalOption> {
  final List<bool> _selectedVegetarian = <bool>[true, false];
  final List<bool> _selectedAllergies = <bool>[
    false,
    false,
    false,
    false,
    false
  ];
  final DatabaseHelper db = DatabaseHelper.instance;
  List<Recipe> suitableRecipes = [];
  final TextEditingController _calorieController = TextEditingController();

  bool vertical = false;

  @override
  void dispose() {
    _calorieController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Text(
            'Set Goal',
            style: TextStyle(color: Colors.black),
          )), //appBar
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Calorie box
            const Text('Enter your preferred calorie intake',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: _calorieController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter calories',
                ),
              ),
            ),
            const SizedBox(height: 50),
            //vegetarian selection
            const Text('Are you vegetarian?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            ToggleButtons(
              direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedVegetarian.length; i++) {
                    _selectedVegetarian[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: const Color.fromARGB(255, 199, 143, 2),
              selectedColor: Colors.black,
              fillColor: Colors.yellow[200],
              color: Colors.yellow[700],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedVegetarian,
              children: vegetarianOptions.map<Widget>((e) => Text(e)).toList(),
            ),

            //AllergyBox
            const SizedBox(height: 20),
            // ToggleButtons with a multiple selection.
            const Text('Do you have any allergy?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            ToggleButtons(
              direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index) {
                // All buttons are selectable.
                setState(() {
                  _selectedAllergies[index] = !_selectedAllergies[index];
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: const Color.fromARGB(255, 199, 143, 2),
              selectedColor: Colors.black,
              fillColor: Colors.yellow[200],
              color: Colors.yellow[700],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 65.0,
              ),
              isSelected: _selectedAllergies,
              children: allergyNames.map<Widget>((e) => Text(e)).toList(),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.yellow, // Set the background color of the button
                onPrimary: Colors.black, // Set the text color
              ),
              onPressed: () async {
                bool isVegetarian = _selectedVegetarian[0];
                List<String> allergies = [];
                for (int i = 0; i < _selectedAllergies.length; i++) {
                  if (_selectedAllergies[i]) allergies.add(allergyNames[i]);
                }

                // Check if calorie input is a valid number
                if (int.tryParse(_calorieController.text) == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Invalid Input'),
                        content:
                            const Text('Please enter a valid calorie goal.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                int calorieGoal = int.parse(_calorieController.text);
                suitableRecipes = await db.getFilteredRecipes(
                    isVegetarian, allergies, calorieGoal);
                //Check if there are recipes to recommend
                if (suitableRecipes.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('No Matching Recipes'),
                        content: const Text(
                            'No matching recipes found for the specified criteria, please try again!'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          MatchRecipes(suitableRecipes: suitableRecipes),
                    ),
                  );
                }
              },
              child: const Text('Match Recipes'),
            ),
          ],
        ),
      ),
    );
  }
}
