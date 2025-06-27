/// Provider for managing admin access and permissions in the KHookbook app.
/// This provider integrates with Firebase Authentication's custom claims system
/// to securely determine and manage admin privileges for users.
import "package:cloud_firestore/cloud_firestore.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "auth_provider.dart";

/// Global provider that exposes the current user's admin status.
/// This provider automatically handles token refreshing to ensure claims are current.
/// Usage:
/// ```dart
/// final isAdmin = ref.watch(adminProvider);
/// return isAdmin.when(
///   data: (isAdmin) => isAdmin ? AdminContent() : UnauthorizedContent(),
///   loading: () => LoadingSpinner(),
///   error: (_, __) => ErrorMessage(),
/// );
/// ```
final adminProvider = StreamProvider<bool>((ref) {
  final auth = ref.watch(authProvider);
  if (auth == null) return Stream.value(false);

  return FirebaseFirestore.instance
      .collection("admins")
      .doc(auth.uid)
      .snapshots()
      .map((doc) => doc.exists);
});
