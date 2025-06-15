import 'package:cloud_firestore/cloud_firestore.dart';

class HalalVerificationService {
  final _db = FirebaseFirestore.instance;

  static const List<String> haramIngredients = [
    'alcohol',
    'wine',
    'beer',
    'pork',
    'bacon',
    'ham',
    'gelatin', // unless specified halal
    'lard',
    // Add more haram ingredients
  ];

  Future<bool> containsHaramIngredients(List<String> ingredients) {
    return Future.value(
      ingredients.any(
        (i) => haramIngredients.any(
          (h) => i.toLowerCase().contains(h.toLowerCase()),
        ),
      ),
    );
  }

  Future<void> verifyRecipe({
    required String recipeId,
    required String verifierId,
    required bool isHalal,
    String? notes,
  }) {
    return _db.collection('verifications').doc(recipeId).set({
      'isHalal': isHalal,
      'verifiedBy': verifierId,
      'verifiedAt': FieldValue.serverTimestamp(),
      'notes': notes,
    });
  }
}
