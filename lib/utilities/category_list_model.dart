class Category {
  final String? id, category, thumbnail, description;

  Category({this.id, this.category, this.thumbnail, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'],
      category: json['strCategory'],
      thumbnail: json['strCategoryThumb'],
      description: json['strCategoryDescription'],
    );
  }

  String toString() {
    return 'idCategory: $id, strCategory: $category, strCategoryThumb: $thumbnail, strCategoryDescription: $description';
  }
}

class CategoriesList {
  final List<Category> categories;

  CategoriesList({required this.categories});

  factory CategoriesList.fromJson(Map<String, dynamic> json, {categories}) {
    return CategoriesList(
      categories: List<Category>.from(
        json['categories'].map((category) => Category.fromJson(category)),
      ),
    );
  }
}
