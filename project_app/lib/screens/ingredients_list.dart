import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_app/models/ingredients.dart';
import 'second_screens/create_recipe.dart';
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
    createListIngredients();
    globals.isCheckboxChecked =
        List<bool>.filled(globals.listIngredients.length, false);
    super.initState();
  }

  void createListIngredients() {
    if (globals.listIngredients.isEmpty) {
      firestoreInstance.collection('ingredients').get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          Map<String, dynamic> data = result.data();
          Ingredients ingredients = Ingredients.fromMap(data);
          globals.listIngredients.add(ingredients);
        }
      });
    }
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
                    child: Text("Show nutritional values ->"),
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
                        "Total Sugars: ${globals.listIngredients[index].totalSugarG} g"
                        "\n"),
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
                        .add(globals.listIngredients[index].name);
                  } else {
                    globals.selectedIngredients
                        .remove(globals.listIngredients[index].name);
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
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("New recipe"),
        onPressed: () {
          if (globals.selectedIngredients.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please, select at least one ingredient",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreateRecipe(globals.selectedIngredients)),
            );
          }
        },
        backgroundColor: const Color.fromARGB(255, 26, 117, 71),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}