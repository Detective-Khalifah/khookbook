/// Provider for managing halal verification state and actions.
/// This provider serves as the interface between the UI and Firestore
/// for all verification-related operations.
import "package:cloud_firestore/cloud_firestore.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

/// Global provider instance for halal verification functionality
final halalVerificationProvider = Provider(
  (ref) => HalalVerificationNotifier(),
);

/// Notifier class that handles all halal verification operations
class HalalVerificationNotifier {
  final _db = FirebaseFirestore.instance;

  /// Submits a new halal verification report for review
  /// This is typically called when a user wants to report incorrect halal status
  ///
  /// @param recipeId ID of the recipe being reported
  /// @param reporterId ID of the user submitting the report
  /// @param notes Additional information about why the current status is incorrect
  Future<void> submitReport({
    required String recipeId,
    required String reporterId,
    required String notes,
  }) async {
    await _db.collection("halal_reports").add({
      "recipeId": recipeId,
      "reporterId": reporterId,
      "notes": notes,
      "status": "pending",
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  /// Updates the verification status of a recipe
  /// This should only be called by admins after reviewing the recipe
  ///
  /// @param recipeId ID of the recipe to verify
  /// @param verifierId ID of the admin performing the verification
  /// @param isHalal Whether the recipe is confirmed as halal
  /// @param haramIngredients List of haram ingredients found (if any)
  /// @param notes Optional notes explaining the verification decision
  Future<void> verifyRecipe({
    required String recipeId,
    required String verifierId,
    required bool isHalal,
    required List<String> haramIngredients,
    String? notes,
  }) async {
    await _db.collection("halal_verifications").doc(recipeId).set({
      "isHalal": isHalal,
      "verifiedBy": verifierId,
      "verifiedAt": FieldValue.serverTimestamp(),
      "haramIngredients": haramIngredients,
      "notes": notes,
    });
  }

  Stream<QuerySnapshot> getReportsForRecipe(String recipeId) {
    return _db
        .collection("halal_reports")
        .where("recipeId", isEqualTo: recipeId)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> getVerification(String recipeId) {
    return _db.collection("halal_verifications").doc(recipeId).snapshots();
  }
}
