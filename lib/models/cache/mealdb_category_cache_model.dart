import "package:hive_ce_flutter/hive_flutter.dart";
import "package:khookbook/models/category_list_model.dart";

class MealDBCategoryCache extends HiveObject {
  final List<MealDBCategoryData> categories;

  final DateTime cachedAt;

  MealDBCategoryCache({required this.categories, required this.cachedAt});

  /// Convert from [CategoriesList] model
  factory MealDBCategoryCache.fromCategoriesList(
    CategoriesList categoriesList,
  ) {
    return MealDBCategoryCache(
      categories: categoriesList.categories
          .map((category) => MealDBCategoryData.fromCategory(category))
          .toList(),
      cachedAt: DateTime.now(),
    );
  }

  CategoriesList toCategoriesList() {
    return CategoriesList(
      categories: categories
          .map((categoryData) => categoryData.toCategory())
          .toList(),
    );
  }
}

class MealDBCategoryData {
  final String? id;

  final String? category;
  final String? thumbnail;
  final String? description;

  MealDBCategoryData({
    this.id,
    this.category,
    this.thumbnail,
    this.description,
  });

  /// Convert from [Category] model
  factory MealDBCategoryData.fromCategory(Category category) {
    return MealDBCategoryData(
      id: category.id,
      category: category.category,
      thumbnail: category.thumbnail,
      description: category.description,
    );
  }

  Category toCategory() {
    return Category(
      id: id,
      category: category,
      thumbnail: thumbnail,
      description: description,
    );
  }
}
