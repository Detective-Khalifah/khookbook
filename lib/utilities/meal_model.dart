class Meal {
  final String? id, meal;
  String mealThumbnail;

  Meal({required this.id, required this.meal, required this.mealThumbnail});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      meal: json['strMeal'],
      mealThumbnail: json['strMealThumb'],
    );
  }

  String toString() {
    return 'idMeal: $id, strMeal: $meal, strMealThumb: $mealThumbnail';
  }
}

class MealsList {
  final List<Meal> meals;

  MealsList({required this.meals});

  factory MealsList.fromJson(Map<String, dynamic> json, {meals}) {
    return MealsList(
      meals: List<Meal>.from(
        json['meals'].map((meal) => Meal.fromJson(meal)),
      ),
    );
  }
}
