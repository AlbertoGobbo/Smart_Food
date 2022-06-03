// To parse this JSON data, do
//
//     final ingredients = ingredientsFromMap(jsonString);

import 'dart:convert';

List<Ingredients> ingredientsFromMap(String str) =>
    List<Ingredients>.from(json.decode(str).map((x) => Ingredients.fromMap(x)));

String ingredientsToMap(List<Ingredients> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Ingredients {
  Ingredients({
    required this.emoji,
    required this.caloriesKcal,
    required this.name,
    required this.totalSugarG,
    required this.proteinG,
    required this.totalFatG,
    required this.carbohydratesG,
    required this.totalFiberG,
  });

  String emoji;
  String caloriesKcal;
  String name;
  String totalSugarG;
  String proteinG;
  String totalFatG;
  String carbohydratesG;
  String totalFiberG;

  Ingredients copyWith({
    required String emoji,
    required String caloriesKcal,
    required String name,
    required String totalSugarG,
    required String proteinG,
    required String totalFatG,
    required String carbohydratesG,
    required String totalFiberG,
  }) =>
      Ingredients(
        emoji: emoji,
        caloriesKcal: caloriesKcal,
        name: name,
        totalSugarG: totalSugarG,
        proteinG: proteinG,
        totalFatG: totalFatG,
        carbohydratesG: carbohydratesG,
        totalFiberG: totalFiberG,
      );

  factory Ingredients.fromMap(Map<String, dynamic> json) => Ingredients(
        emoji: json["emoji"],
        caloriesKcal: json["Calories (kcal)"],
        name: json["name"],
        totalSugarG: json["Total Sugar (g)"],
        proteinG: json["Protein (g)"],
        totalFatG: json["Total Fat (g)"],
        carbohydratesG: json["Carbohydrates (g)"],
        totalFiberG: json["Total Fiber (g)"],
      );

  Map<String, dynamic> toMap() => {
        "emoji": emoji,
        "Calories (kcal)": caloriesKcal,
        "name": name,
        "Total Sugar (g)": totalSugarG,
        "Protein (g)": proteinG,
        "Total Fat (g)": totalFatG,
        "Carbohydrates (g)": carbohydratesG,
        "Total Fiber (g)": totalFiberG,
      };
}