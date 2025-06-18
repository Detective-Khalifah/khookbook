import "package:cloud_firestore/cloud_firestore.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "auth_provider.dart";

final adminProvider = StreamProvider<bool>((ref) {
  final auth = ref.watch(authProvider);
  if (auth == null) return Stream.value(false);

  return FirebaseFirestore.instance
      .collection("admins")
      .doc(auth.uid)
      .snapshots()
      .map((doc) => doc.exists);
});
