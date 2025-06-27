/// Provider for tracking and exposing halal verification statistics.
/// Maintains a real-time connection to Firestore to update stats as verifications change.
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:cloud_firestore/cloud_firestore.dart";

/// Global provider instance that streams halal verification statistics
final halalStatsProvider = StreamProvider<HalalStats>((ref) {
  final db = FirebaseFirestore.instance;

  return db.collection("halal_verifications").snapshots().map((snapshot) {
    int verifiedCount = 0;
    int halalCount = 0;
    int pendingReportsCount = 0;

    for (var doc in snapshot.docs) {
      verifiedCount++;
      if (doc.data()["isHalal"] == true) {
        halalCount++;
      }
    }

    return HalalStats(
      totalVerified: verifiedCount,
      totalHalal: halalCount,
      pendingReports: pendingReportsCount,
    );
  });
});

/// Data class containing statistics about halal verifications
class HalalStats {
  /// Total number of recipes that have been verified
  final int totalVerified;

  /// Number of recipes that were verified as halal
  final int totalHalal;

  /// Number of reports awaiting admin review
  final int pendingReports;

  const HalalStats({
    required this.totalVerified,
    required this.totalHalal,
    required this.pendingReports,
  });

  /// Percentage of verified recipes that are halal
  double get halalPercentage =>
      totalVerified > 0 ? (totalHalal / totalVerified) * 100 : 0;
}
