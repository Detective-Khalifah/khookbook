class CategoryMeals {
  final String id, name, thumbnailUrl;

  CategoryMeals(
      {required this.id, required this.name, required this.thumbnailUrl});

  factory CategoryMeals.fromJson(Map<String, dynamic> json) {
    return CategoryMeals(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnailUrl: json['strMealThumb'],
    );
  }

  @override
  String toString() {
    return 'idMeal: $id, strMeal: $name, strMealThumb: $thumbnailUrl';
  }
}

class CategoryMealsList {
  final List<CategoryMeals> meals;

  CategoryMealsList({required this.meals});

  factory CategoryMealsList.fromJson(Map<String, dynamic> json) {
    return CategoryMealsList(
      meals: (json['meals'] as List<dynamic>)
          .map((e) => CategoryMeals.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // factory CategoryMealsList.fromJson(Map<String, dynamic> json, {meals}) {
  //   return CategoryMealsList(
  //     meals: List<CategoryMeals>.from(
  //       json['meals'].map((meal) => CategoryMeals.fromJson(meal)),
  //     ),
  //   );
  // }
}
