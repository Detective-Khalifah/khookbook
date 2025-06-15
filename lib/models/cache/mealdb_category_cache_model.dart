import "package:hive_ce_flutter/hive_flutter.dart";
import "package:khookbook/models/category_list_model.dart";

part "mealdb_category_cache_model.g.dart";

@HiveType(typeId: 1)
class MealDBCategoryCache extends HiveObject {
  @HiveField(0)
  final List<MealDBCategoryData> categories;

  @HiveField(1)
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

@HiveType(typeId: 2)
class MealDBCategoryData {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? category;

  @HiveField(2)
  final String? thumbnail;

  @HiveField(3)
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
