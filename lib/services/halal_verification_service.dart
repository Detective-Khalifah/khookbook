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

  static const List<String> suspectIngredients = [
    "gelatin", // might be halal if specified
    "rennet", // might be halal if specified
    "enzymes", // need verification
    "emulsifiers", // need verification
    "shortening", // might contain lard
    "vanilla extract", // might contain alcohol
  ];

  Future<bool> containsHaramIngredients(List<String> ingredients) async {
    // Convert ingredients to lowercase for case-insensitive comparison
    final lowerIngredients = ingredients.map((i) => i.toLowerCase()).toList();

    // Check for direct matches with haram ingredients
    final hasHaram = haramIngredients.any(
      (h) => lowerIngredients.any((i) => i.contains(h.toLowerCase())),
    );

    if (hasHaram) return true;

    // Check for suspect ingredients that need verification
    final hasSuspect = suspectIngredients.any(
      (s) => lowerIngredients.any((i) => i.contains(s.toLowerCase())),
    );

    // For now, we'll treat suspect ingredients as potentially halal
    // In a full implementation, these would require manual verification
    return false;
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
