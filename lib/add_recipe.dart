import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database_helper.dart';

class AddRecipe extends StatefulWidget{
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => AddRecipeState();
}

class AddRecipeState extends State<AddRecipe>{
  List<int> values = [0, 0, 0, 0, 0, 0, 0, 0];
  String name = '';
  String instructions = '';
  bool isVegetarian = false;
  List<String> allergies = [];
  Future<dynamic> saveRecipe()async{
    await DatabaseHelper.instance.add(Recipe(name: name,
        ingredientAmount: '${values[0]},${values[1]},${values[2]},${values[3]},${values[4]},${values[5]},${values[6]},${values[7]},' ,
        instructions: instructions,
        isVegetarian: isVegetarian,
        allergies: allergies
        ));
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.yellow, title: const Text('Add Recipe', style: TextStyle(color: Colors.black),)),//appBar
      body: Center(
        child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                onChanged: (text) => name = text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(ingredientList[0].name),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                height: 80,
                child: IntegerSpinnerField(
                  value: values[0],
                  //autofocus: true,
                  onChanged: (int newValue) {
                    if (values[0] == newValue) {
                      // Avoid unnecessary redraws.
                      return;
                    }
                    setState(() {
                      // Update the value and redraw.
                      values[0] = newValue;
                    });
                  },
                ),
              ),
            ),
            Text(ingredientList[1].name),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                height: 80,
                child: IntegerSpinnerField(
                  value: values[1],
                  //autofocus: true,
                  onChanged: (int newValue) {
                    if (values[1] == newValue) {
                      // Avoid unnecessary redraws.
                      return;
                    }
                    setState(() {
                      // Update the value and redraw.
                      values[1] = newValue;
                    });
                  },
                ),
              ),
            ),
            Text(ingredientList[2].name),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                height: 80,
                child: IntegerSpinnerField(
                  value: values[2],
                  //autofocus: true,
                  onChanged: (int newValue) {
                    if (values[2] == newValue) {
                      // Avoid unnecessary redraws.
                      return;
                    }
                    setState(() {
                      // Update the value and redraw.
                      values[2] = newValue;
                    });
                  },
                ),
              ),
            ),
            Text(ingredientList[3].name),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                height: 80,
                child: IntegerSpinnerField(
                  value: values[3],
                  //autofocus: true,
                  onChanged: (int newValue) {
                    if (values[3] == newValue) {
                      // Avoid unnecessary redraws.
                      return;
                    }
                    setState(() {
                      // Update the value and redraw.
                      values[3] = newValue;
                    });
                  },
                ),
              ),
            ),
            Text(ingredientList[4].name),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                height: 80,
                child: IntegerSpinnerField(
                  value: values[4],
                  //autofocus: true,
                  onChanged: (int newValue) {
                    if (values[4] == newValue) {
                      // Avoid unnecessary redraws.
                      return;
                    }
                    setState(() {
                      // Update the value and redraw.
                      values[4] = newValue;
                    });
                  },
                ),
              ),
            ),
            Text(ingredientList[5].name),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                height: 80,
                child: IntegerSpinnerField(
                  value: values[5],
                  //autofocus: true,
                  onChanged: (int newValue) {
                    if (values[5] == newValue) {
                      // Avoid unnecessary redraws.
                      return;
                    }
                    setState(() {
                      // Update the value and redraw.
                      values[5] = newValue;
                    });
                  },
                ),
              ),
            ),
            Text(ingredientList[6].name),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                height: 80,
                child: IntegerSpinnerField(
                  value: values[6],
                  //autofocus: true,
                  onChanged: (int newValue) {
                    if (values[6] == newValue) {
                      // Avoid unnecessary redraws.
                      return;
                    }
                    setState(() {
                      // Update the value and redraw.
                      values[6] = newValue;
                    });
                  },
                ),
              ),
            ),
            Text(ingredientList[7].name),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                height: 80,
                child: IntegerSpinnerField(
                  value: values[7],
                  //autofocus: true,
                  onChanged: (int newValue) {
                    if (values[7] == newValue) {
                      // Avoid unnecessary redraws.
                      return;
                    }
                    setState(() {
                      // Update the value and redraw.
                      values[7] = newValue;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 300,
              width: 300,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (text) => instructions = text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Instructions',
                ),
              ),
            ),


            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow, // Set the background color of the button
                onPrimary: Colors.black, // Set the text color
              ),
              onPressed:() {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow, // Set the background color of the button
                onPrimary: Colors.black, // Set the text color
              ),
              onPressed:() {
                saveRecipe().then((result) {
                    Navigator.pop(context);
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

/// An integer example of the generic [SpinnerField] that validates input and
/// increments by a delta.
class IntegerSpinnerField extends StatelessWidget {
  const IntegerSpinnerField({
    super.key,
    required this.value,
    this.autofocus = false,
    this.delta = 1,
    this.onChanged,
  });

  final int value;
  final bool autofocus;
  final int delta;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SpinnerField<int>(
      value: value,
      onChanged: onChanged,
      autofocus: autofocus,
      fromString: (String stringValue) => int.tryParse(stringValue) ?? value,
      increment: (int i) => i + delta,
      decrement: (int i) {
        if(i > 0) {
          i = i - delta;
        }
        return i;
      },
      // Add a text formatter that only allows integer values and a leading
      // minus sign.
      inputFormatters: <TextInputFormatter>[
        TextInputFormatter.withFunction(
              (TextEditingValue oldValue, TextEditingValue newValue) {
            //String newString;
            /*if (newValue.text.startsWith('-')) {
              newString = newValue.text.replaceAll(RegExp(r'\D'), '');
            } else {
              newString = newValue.text.replaceAll(RegExp(r'\D'), '');
            }*/
            return newValue.copyWith(
              text: newValue.text.replaceAll(RegExp(r'\D'), ''),
              selection: newValue.selection.copyWith(
                baseOffset:
                newValue.selection.baseOffset.clamp(0, newValue.text.replaceAll(RegExp(r'\D'), '').length),
                extentOffset:
                newValue.selection.extentOffset.clamp(0, newValue.text.replaceAll(RegExp(r'\D'), '').length),
              ),
            );
          },
        )
      ],
    );
  }
}

class SpinnerField<T> extends StatefulWidget {
  SpinnerField({
    super.key,
    required this.value,
    required this.fromString,
    this.autofocus = false,
    String Function(T value)? asString,
    this.increment,
    this.decrement,
    this.onChanged,
    this.inputFormatters = const <TextInputFormatter>[],
  }) : asString = asString ?? ((T value) => value.toString());

  final T value;
  final T Function(T value)? increment;
  final T Function(T value)? decrement;
  final String Function(T value) asString;
  final T Function(String value) fromString;
  final ValueChanged<T>? onChanged;
  final List<TextInputFormatter> inputFormatters;
  final bool autofocus;

  @override
  State<SpinnerField<T>> createState() => _SpinnerFieldState<T>();
}

class _SpinnerFieldState<T> extends State<SpinnerField<T>> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateText(widget.asString(widget.value));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SpinnerField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.asString != widget.asString ||
        oldWidget.value != widget.value) {
      final String newText = widget.asString(widget.value);
      _updateText(newText);
    }
  }

  void _updateText(String text, {bool collapsed = true}) {
    if (text != controller.text) {
      controller.value = TextEditingValue(
        text: text,
        selection: collapsed
            ? TextSelection.collapsed(offset: text.length)
            : TextSelection(baseOffset: 0, extentOffset: text.length),
      );
    }
  }

  void _spin(T Function(T value)? spinFunction) {
    if (spinFunction == null) {
      return;
    }
    final T newValue = spinFunction(widget.value);
    widget.onChanged?.call(newValue);
    _updateText(widget.asString(newValue), collapsed: false);
  }

  void _increment() {
    _spin(widget.increment);
  }

  void _decrement() {
    _spin(widget.decrement);
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowUp): _increment,
        const SingleActivator(LogicalKeyboardKey.arrowDown): _decrement,
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              autofocus: widget.autofocus,
              inputFormatters: widget.inputFormatters,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) =>
                  widget.onChanged?.call(widget.fromString(value)),
              controller: controller,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          // Without this TextFieldTapRegion, tapping on the buttons below would
          // increment the value, but it would cause the text field to be
          // unfocused, since tapping outside of a text field should unfocus it
          // on non-mobile platforms.
          TextFieldTapRegion(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: _increment,
                    child: const Icon(Icons.add),
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _decrement,
                    child: const Icon(Icons.remove),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}