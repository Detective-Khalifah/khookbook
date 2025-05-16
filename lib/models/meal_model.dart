class Meal {
  final String id;
  final String instructions;
  final String name;
  final String thumbnailUrl;
  final String? area, source, youtubeUrl;

  // Instead of ingredient1…ingredient20 + measure1…measure20:
  final List<String?> ingredients;
  final List<String?> measures;

  Meal({
    required this.id,
    required this.instructions,
    required this.name,
    required this.thumbnailUrl,
    this.area,
    this.source,
    this.youtubeUrl,
    required this.ingredients,
    required this.measures,
    // required String meal,
    // required String mealThumbnail,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    // Dynamically collect the 20 pairs
    final ingredients = List<String?>.generate(
      20,
      (i) => json['strIngredient${i + 1}'] as String?,
    );
    final measures = List<String?>.generate(
      20,
      (i) => json['strMeasure${i + 1}'] as String?,
    );
    return Meal(
      id: json['idMeal'] as String,
      instructions: json['strInstructions'] as String,
      name: json['strMeal'] as String,
      thumbnailUrl: json['strMealThumb'] as String,
      area: json['strArea'] as String?,
      source: json['strSource'] as String?,
      youtubeUrl: json['strYoutube'] as String?,
      ingredients: ingredients,
      measures: measures,
    );
  }
}

extension MealIngredients on Meal {
  /// Returns list of “Ingredient (Measure)” pairs, skipping empties.
  List<String> get ingredientPairs {
    final pairs = <String>[];
    for (var i = 0; i < ingredients.length; i++) {
      final ing = ingredients[i]?.trim();
      final meas = measures[i]?.trim();
      if (ing != null && ing.isNotEmpty) {
        pairs.add(meas != null && meas.isNotEmpty ? '$ing ($meas)' : ing);
      }
    }
    return pairs;
  }
}

class MealSpecs {
  final List<Meal> meals;
  MealSpecs(this.meals);

  factory MealSpecs.fromJson(Map<String, dynamic> json) => MealSpecs(
        (json['meals'] as List)
            .map((e) => Meal.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

// class Meal {
//   final String? id, cuisineLocale, meal, source, ytLink;
//   String mealThumbnail, instructions;

//   // 15 String Ingredients
//   final String? ingredient1,
//       ingredient2,
//       ingredient3,
//       ingredient4,
//       ingredient5,
//       ingredient6,
//       ingredient7,
//       ingredient8,
//       ingredient9,
//       ingredient10,
//       ingredient11,
//       ingredient12,
//       ingredient13,
//       ingredient14,
//       ingredient15,
//       ingredient16,
//       ingredient17,
//       ingredient18,
//       ingredient19,
//       ingredient20;

//   // 15 String measures
//   final String? measure1,
//       measure2,
//       measure3,
//       measure4,
//       measure5,
//       measure6,
//       measure7,
//       measure8,
//       measure9,
//       measure10,
//       measure11,
//       measure12,
//       measure13,
//       measure14,
//       measure15,
//       measure16,
//       measure17,
//       measure18,
//       measure19,
//       measure20;

//   Meal(
//       {this.ingredient1,
//       this.ingredient2,
//       this.ingredient3,
//       this.ingredient4,
//       this.ingredient5,
//       this.ingredient6,
//       this.ingredient7,
//       this.ingredient8,
//       this.ingredient9,
//       this.ingredient10,
//       this.ingredient11,
//       this.ingredient12,
//       this.ingredient13,
//       this.ingredient14,
//       this.ingredient15,
//       this.ingredient16,
//       this.ingredient17,
//       this.ingredient18,
//       this.ingredient19,
//       this.ingredient20,
//       this.measure1,
//       this.measure2,
//       this.measure3,
//       this.measure4,
//       this.measure5,
//       this.measure6,
//       this.measure7,
//       this.measure8,
//       this.measure9,
//       this.measure10,
//       this.measure11,
//       this.measure12,
//       this.measure13,
//       this.measure14,
//       this.measure15,
//       this.measure16,
//       this.measure17,
//       this.measure18,
//       this.measure19,
//       this.measure20,
//       required this.id,
//       required this.instructions,
//       required this.meal,
//       required this.mealThumbnail,
//       this.cuisineLocale,
//       this.source,
//       this.ytLink});

//   factory Meal.fromJson(Map<String, dynamic> json) {
//     return Meal(
//       id: json['idMeal'],
//       instructions: json['strInstructions'],
//       meal: json['strMeal'],
//       mealThumbnail: json['strMealThumb'],
//       cuisineLocale: json['strArea'],
//       source: json['strSource'],
//       ytLink: json['strYoutube'],

//       // Ingredients
//       ingredient1: json['strIngredient1'],
//       ingredient2: json['strIngredient2'],
//       ingredient3: json['strIngredient3'],
//       ingredient4: json['strIngredient4'],
//       ingredient5: json['strIngredient5'],
//       ingredient6: json['strIngredient6'],
//       ingredient7: json['strIngredient7'],
//       ingredient8: json['strIngredient8'],
//       ingredient9: json['strIngredient9'],
//       ingredient10: json['strIngredient10'],
//       ingredient11: json['strIngredient11'],
//       ingredient12: json['strIngredient12'],
//       ingredient13: json['strIngredient13'],
//       ingredient14: json['strIngredient14'],
//       ingredient15: json['strIngredient15'],
//       ingredient16: json['strIngredient16'],
//       ingredient17: json['strIngredient17'],
//       ingredient18: json['strIngredient18'],
//       ingredient19: json['strIngredient19'],
//       ingredient20: json['strIngredient20'],

//       // Measures
//       measure1: json['strMeasure1'],
//       measure2: json['strMeasure2'],
//       measure3: json['strMeasure3'],
//       measure4: json['strMeasure4'],
//       measure5: json['strMeasure5'],
//       measure6: json['strMeasure6'],
//       measure7: json['strMeasure7'],
//       measure8: json['strMeasure8'],
//       measure9: json['strMeasure9'],
//       measure10: json['strMeasure10'],
//       measure11: json['strMeasure11'],
//       measure12: json['strMeasure12'],
//       measure13: json['strMeasure13'],
//       measure14: json['strMeasure14'],
//       measure15: json['strMeasure15'],
//       measure16: json['strMeasure16'],
//       measure17: json['strMeasure17'],
//       measure18: json['strMeasure18'],
//       measure19: json['strMeasure19'],
//       measure20: json['strMeasure20'],
//     );
//   }

//   String toString() {
//     return 'idMeal: $id, strMeal: $meal, strMealThumb: $mealThumbnail, '
//         'strArea: $cuisineLocale, strInstructions: $instructions, '
//         'strSource: $source, strYoutube: $ytLink, '
//         'strIngredient1: $ingredient1, strIngredient2: $ingredient2, '
//         'strIngredient3: $ingredient3, strIngredient4: $ingredient4, '
//         'strIngredient5: $ingredient5, strIngredient6: $ingredient6, '
//         'strIngredient7: $ingredient7, strIngredient8: $ingredient8, '
//         'strIngredient9: $ingredient9, strIngredient10: $ingredient10, '
//         'strIngredient11: $ingredient11, strIngredient12: $ingredient12, '
//         'strIngredient13: $ingredient13, strIngredient14: $ingredient14, '
//         'strIngredient15: $ingredient15, strIngredient16: $ingredient16, '
//         'strIngredient17: $ingredient17, strIngredient18: $ingredient18, '
//         'strIngredient19: $ingredient19, strIngredient20: $ingredient20, '
//         'strMeasure1: $measure1, strMeasure2: $measure2, strMeasure3: $measure3, '
//         'strMeasure4: $measure4, strMeasure5: $measure5, strMeasure6: $measure6, '
//         'strMeasure7: $measure7, strMeasure8: $measure8, strMeasure9: $measure9, '
//         'strMeasure10: $measure10, strMeasure11: $measure11, strMeasure12: $measure12, '
//         'strMeasure13: $measure13, strMeasure14: $measure14, strMeasure15: $measure15, '
//         'strMeasure16: $measure16, strMeasure17: $measure17, strMeasure18: $measure18, '
//         'strMeasure19: $measure19, strMeasure20: $measure20';
//   }
// }

// class MealSpecs {
//   final List<Meal> mealSpecs;

//   MealSpecs({required this.mealSpecs});

//   factory MealSpecs.fromJson(Map<String, dynamic> json, {mealSpecs}) {
//     return MealSpecs(
//       mealSpecs: List<Meal>.from(
//         json['meals'].map((meal) => Meal.fromJson(meal)),
//       ),
//     );
//   }
// }
