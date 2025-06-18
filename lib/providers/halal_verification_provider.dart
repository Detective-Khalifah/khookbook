import "package:cloud_firestore/cloud_firestore.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

final halalVerificationProvider = Provider(
  (ref) => HalalVerificationNotifier(),
);

class HalalVerificationNotifier {
  final _db = FirebaseFirestore.instance;

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
