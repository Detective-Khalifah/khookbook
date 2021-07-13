class Meal {
  final String? id, meal, source, ytLink;
  String mealThumbnail, instructions;

  // 15 String Ingredients
  final String? ingredient1,
      ingredient2,
      ingredient3,
      ingredient4,
      ingredient5,
      ingredient6,
      ingredient7,
      ingredient8,
      ingredient9,
      ingredient10,
      ingredient11,
      ingredient12,
      ingredient13,
      ingredient14,
      ingredient15;

  // 15 String measures
  final String? measure1,
      measure2,
      measure3,
      measure4,
      measure5,
      measure6,
      measure7,
      measure8,
      measure9,
      measure10,
      measure11,
      measure12,
      measure13,
      measure14,
      measure15;

  Meal(
      {this.ingredient1,
      this.ingredient2,
      this.ingredient3,
      this.ingredient4,
      this.ingredient5,
      this.ingredient6,
      this.ingredient7,
      this.ingredient8,
      this.ingredient9,
      this.ingredient10,
      this.ingredient11,
      this.ingredient12,
      this.ingredient13,
      this.ingredient14,
      this.ingredient15,
      this.measure1,
      this.measure2,
      this.measure3,
      this.measure4,
      this.measure5,
      this.measure6,
      this.measure7,
      this.measure8,
      this.measure9,
      this.measure10,
      this.measure11,
      this.measure12,
      this.measure13,
      this.measure14,
      this.measure15,
      required this.id,
      required this.instructions,
      required this.meal,
      required this.mealThumbnail,
      this.source,
      this.ytLink});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      instructions: json['strInstructions'],
      meal: json['strMeal'],
      mealThumbnail: json['strMealThumb'],
      source: json['strSource'],
      ytLink: json['strYoutube'],

      // Ingredients
      ingredient1: json['strIngredient1'],
      ingredient2: json['strIngredient2'],
      ingredient3: json['strIngredient3'],
      ingredient4: json['strIngredient4'],
      ingredient5: json['strIngredient5'],
      ingredient6: json['strIngredient6'],
      ingredient7: json['strIngredient7'],
      ingredient8: json['strIngredient8'],
      ingredient9: json['strIngredient9'],
      ingredient10: json['strIngredient10'],
      ingredient11: json['strIngredient11'],
      ingredient12: json['strIngredient12'],
      ingredient13: json['strIngredient13'],
      ingredient14: json['strIngredient14'],
      ingredient15: json['strIngredient15'],

      // Measures
      measure1: json['strMeasure1'],
      measure2: json['strMeasure2'],
      measure3: json['strMeasure3'],
      measure4: json['strMeasure4'],
      measure5: json['strMeasure5'],
      measure6: json['strMeasure6'],
      measure7: json['strMeasure7'],
      measure8: json['strMeasure8'],
      measure9: json['strMeasure9'],
      measure10: json['strMeasure10'],
      measure11: json['strMeasure11'],
      measure12: json['strMeasure12'],
      measure13: json['strMeasure13'],
      measure14: json['strMeasure14'],
      measure15: json['strMeasure15'],
    );
  }

  String toString() {
    return 'idMeal: $id, strMeal: $meal, strMealThumb: $mealThumbnail';
  }
}

class MealSpecs {
  final List<Meal> mealSpecs;

  MealSpecs({required this.mealSpecs});

  factory MealSpecs.fromJson(Map<String, dynamic> json, {mealSpecs}) {
    return MealSpecs(
      mealSpecs: List<Meal>.from(
        json['meals'].map((meal) => Meal.fromJson(meal)),
      ),
    );
  }
}
