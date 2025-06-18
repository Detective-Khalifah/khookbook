// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_const, require_trailing_commas, document_ignores, public_member_api_docs

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class MealDBCategoryCacheAdapter extends TypeAdapter<MealDBCategoryCache> {
  @override
  final typeId = 1;

  @override
  MealDBCategoryCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealDBCategoryCache(
      categories: (fields[0] as List).cast<MealDBCategoryData>(),
      cachedAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MealDBCategoryCache obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.categories)
      ..writeByte(1)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealDBCategoryCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MealDBCategoryDataAdapter extends TypeAdapter<MealDBCategoryData> {
  @override
  final typeId = 2;

  @override
  MealDBCategoryData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealDBCategoryData(
      id: fields[0] as String?,
      category: fields[1] as String?,
      thumbnail: fields[2] as String?,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MealDBCategoryData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.thumbnail)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealDBCategoryDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MealDBCategoryMealsCacheAdapter
    extends TypeAdapter<MealDBCategoryMealsCache> {
  @override
  final typeId = 3;

  @override
  MealDBCategoryMealsCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealDBCategoryMealsCache(
      categoryId: fields[0] as String,
      meals: (fields[1] as List).cast<MealDBCategoryMealData>(),
      cachedAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MealDBCategoryMealsCache obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.meals)
      ..writeByte(2)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealDBCategoryMealsCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MealDBCategoryMealDataAdapter
    extends TypeAdapter<MealDBCategoryMealData> {
  @override
  final typeId = 4;

  @override
  MealDBCategoryMealData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealDBCategoryMealData(
      id: fields[0] as String,
      name: fields[1] as String,
      thumbnailUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MealDBCategoryMealData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.thumbnailUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealDBCategoryMealDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MealDBMealCacheAdapter extends TypeAdapter<MealDBMealCache> {
  @override
  final typeId = 5;

  @override
  MealDBMealCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealDBMealCache(
      id: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as String?,
      instructions: fields[3] as String,
      thumbnailUrl: fields[4] as String,
      ingredients: (fields[5] as List).cast<String?>(),
      measures: (fields[6] as List).cast<String?>(),
      area: fields[7] as String?,
      tags: fields[8] as String?,
      youtubeUrl: fields[9] as String?,
      source: fields[10] as String?,
      cachedAt: fields[11] as DateTime,
      containsHaramIngredients: fields[12] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MealDBMealCache obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.instructions)
      ..writeByte(4)
      ..write(obj.thumbnailUrl)
      ..writeByte(5)
      ..write(obj.ingredients)
      ..writeByte(6)
      ..write(obj.measures)
      ..writeByte(7)
      ..write(obj.area)
      ..writeByte(8)
      ..write(obj.tags)
      ..writeByte(9)
      ..write(obj.youtubeUrl)
      ..writeByte(10)
      ..write(obj.source)
      ..writeByte(11)
      ..write(obj.cachedAt)
      ..writeByte(12)
      ..write(obj.containsHaramIngredients);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealDBMealCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppPreferencesAdapter extends TypeAdapter<AppPreferences> {
  @override
  final typeId = 6;

  @override
  AppPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppPreferences(
      notificationsEnabled: fields[0] == null ? true : fields[0] as bool,
      halalFilterEnabled: fields[1] == null ? true : fields[1] as bool,
      language: fields[2] == null ? "English" : fields[2] as String,
      themeMode: fields[3] == null ? ThemeMode.system : fields[3] as ThemeMode,
    );
  }

  @override
  void write(BinaryWriter writer, AppPreferences obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.notificationsEnabled)
      ..writeByte(1)
      ..write(obj.halalFilterEnabled)
      ..writeByte(2)
      ..write(obj.language)
      ..writeByte(3)
      ..write(obj.themeMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final typeId = 8;

  @override
  ThemeMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    switch (obj) {
      case ThemeMode.system:
        writer.writeByte(0);
      case ThemeMode.light:
        writer.writeByte(1);
      case ThemeMode.dark:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
