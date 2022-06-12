import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_app/models/ingredients.dart';
import 'package:project_app/variables/global_variables.dart' as globals;

class IngredientsList extends StatelessWidget {
  const IngredientsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StatefulIngredientsList(),
    );
  }
}

class StatefulIngredientsList extends StatefulWidget {
  const StatefulIngredientsList({Key? key}) : super(key: key);

  @override
  State<StatefulIngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<StatefulIngredientsList> {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    globals.isCheckboxChecked = List<bool>.filled(
        globals.listIngredients.length, false,
        growable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: globals.listIngredients.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              globals.listIngredients[index].name.toUpperCase(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: globals.isCheckboxChecked[index] == false
                ? const Visibility(
                    child: Text("Tap to see nutritional values"),
                    visible: true,
                  )
                : Visibility(
                    child: Text(
                        "Calories: ${globals.listIngredients[index].caloriesKcal} Kcal"
                        "\n"
                        "Carbohydrates: ${globals.listIngredients[index].carbohydratesG} g"
                        "\n"
                        "Proteins: ${globals.listIngredients[index].proteinG} g"
                        "\n"
                        "Total Fats: ${globals.listIngredients[index].totalFatG} g"
                        "\n"
                        "Total Fibers: ${globals.listIngredients[index].totalFiberG} g"
                        "\n"
                        "Total Sugars: ${globals.listIngredients[index].totalSugarG} g"),
                    visible: true,
                  ),
            secondary: Text(globals.listIngredients[index].emoji,
                style: const TextStyle(fontSize: 40)),
            activeColor: const Color.fromARGB(255, 26, 117, 71),
            controlAffinity: ListTileControlAffinity.leading,
            value: globals.isCheckboxChecked[index],
            onChanged: (bool? value) {
              setState(
                () {
                  globals.isCheckboxChecked[index] = value!;
                  if (globals.isCheckboxChecked[index] == true) {
                    globals.selectedIngredients
                        .add(globals.listIngredients[index]);
                  } else {
                    globals.selectedIngredients
                        .remove(globals.listIngredients[index]);
                  }
                },
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
