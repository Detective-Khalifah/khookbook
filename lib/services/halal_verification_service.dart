/// Service responsible for verifying halal status of recipes and managing
/// the verification process. It maintains lists of known haram and suspect
/// ingredients, and provides methods for automated and manual verification.
import "package:cloud_firestore/cloud_firestore.dart";

class HalalVerificationService {
  final _db = FirebaseFirestore.instance;

  /// Comprehensive list of ingredients that are definitively not halal.
  /// This list is used for automated screening of recipes.
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

  /// List of ingredients that require manual verification.
  /// These ingredients might be halal or haram depending on their source
  /// and processing methods.
  static const List<String> suspectIngredients = [
    "gelatin", // might be halal if specified
    "rennet", // might be halal if specified
    "enzymes", // need verification
    "emulsifiers", // need verification
    "shortening", // might contain lard
  ];

  /// Checks if a list of ingredients contains any known haram ingredients.
  /// This is an automated first-pass check and may require manual verification
  /// for suspect ingredients.
  ///
  /// @param ingredients List of ingredient names to check
  /// @return true if haram ingredients are found, false otherwise
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

  /// Records a halal verification for a recipe in Firestore.
  /// This method should only be called by authorized verifiers.
  ///
  /// @param recipeId The ID of the recipe being verified
  /// @param verifierId The ID of the admin performing the verification
  /// @param isHalal Whether the recipe is verified as halal
  /// @param notes Optional notes about the verification decision
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
