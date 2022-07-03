import 'package:flutter/material.dart';

class AddDailyCaloriesHelp extends StatelessWidget {
  const AddDailyCaloriesHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add daily calories'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Align(
              // TEXT
              alignment: Alignment.centerLeft,
              child: Text(
                "- Tap on the circular slider box.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              // IMAGE
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/create_recipe/create_recipe_1.gif",
                scale: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            const Align(
              // TEXT
              alignment: Alignment.centerLeft,
              child: Text(
                  "- If you are sure about your calories target, enter the number of calories on the text field and tap the 'Set Calories' button.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            Align(
              // IMAGE
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/create_recipe/create_recipe_2.jpg",
                scale: 2,
              ),
            ),
            const SizedBox(height: 40),
            const Align(
              // TEXT
              alignment: Alignment.centerLeft,
              child: Text(
                  "- Otherwise, your application can help you to set your goal inserting some information about you. Indeed, you need to insert your age, weight and height on the text fields and tap on the other available options. Tapping on the 'Calculate Calories' button, the suggested calories are given, and you can set them tapping on 'Set Goal' or turn back to the data tapping on 'Recalculate'.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            Align(
              // IMAGE
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/create_recipe/create_recipe_3.gif",
                scale: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            const Align(
              // TEXT
              alignment: Alignment.centerLeft,
              child: Text(
                  "Once you set the calories goal, the circular slider box in the homepage is updated.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
