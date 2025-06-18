import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:cloud_firestore/cloud_firestore.dart";

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

class HalalStats {
  final int totalVerified;
  final int totalHalal;
  final int pendingReports;

  const HalalStats({
    required this.totalVerified,
    required this.totalHalal,
    required this.pendingReports,
  });

  double get halalPercentage =>
      totalVerified > 0 ? (totalHalal / totalVerified) * 100 : 0;
}
