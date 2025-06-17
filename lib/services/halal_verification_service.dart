import "package:cloud_firestore/cloud_firestore.dart";

class HalalVerificationService {
  final _db = FirebaseFirestore.instance;

  static const List<String> haramIngredients = [
    // Alcohol and derivatives
    "alcohol",
    "wine",
    "beer",
    "liquor",
    "spirit",
    "whiskey",
    "vodka",
    "rum",
    "cognac",
    "brandy",
    "sake",
    "champagne",
    "alcohol-based extracts",
    "alcohol-based flavorings",

    // Pork and pig-derived products
    "pork",
    "bacon",
    "ham",
    "pork belly",
    "lard",
    "pig",
    "pig's feet",
    "prosciutto",
    "gammon",
    "chicharrones",
    "pork rinds",

    // Gelatin and derivatives (when non-halal)
    "gelatin", // unless specified halal
    // Non-zabiha meats and blood products
    "non-zabiha meat", // any meat not slaughtered according to Islamic law
    "blood",
    "blood sausage",

    // Enzymes and animal-derived additives (if non-halal)
    "rennet", // if derived from non-halal sources
    "pepsin", // if derived from non-halal sources
    "tallow",

    // Hidden additives and processing aids
    "bone char", // used in some sugar processing methods
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
    return _db.collection("verifications").doc(recipeId).set({
      "isHalal": isHalal,
      "verifiedBy": verifierId,
      "verifiedAt": FieldValue.serverTimestamp(),
      "notes": notes,
    });
  }
}
