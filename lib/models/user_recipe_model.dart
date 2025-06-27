import 'package:cloud_firestore/cloud_firestore.dart'
    show Timestamp, DocumentSnapshot, SnapshotOptions;

/// User-created recipe model with halal verification support.
///
/// This model represents recipes created by users, with additional fields
/// for tracking halal verification status:
/// - [verificationStatus]: Current verification state ('pending', 'halal', 'haram')
/// - [isHalal]: Final verified halal status
/// - [verifiedBy]: ID of the admin who performed verification
/// - [verifiedAt]: Timestamp of verification
///
/// The model supports both Firestore serialization and deserialization.
class UserRecipe {
  final String id;
  final String name, category, instructions, thumbnail;

  final List<String?> ingredients, measures;

  // Halal verification fields
  String? verificationStatus; // 'pending', 'halal', 'haram'
  bool? isHalal; // Verified halal status
  String? verifiedBy; // UID of verifier
  Timestamp? verifiedAt;

  UserRecipe({
    required this.id,
    required this.name,
    required this.category,
    required this.instructions,
    required this.thumbnail,
    required this.ingredients,
    required this.measures,
    this.verificationStatus = 'pending',
    this.verifiedBy,
    this.verifiedAt,
  });

  factory UserRecipe.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return UserRecipe(
      id: snapshot.id,
      name: data['name'],
      category: data['category'],
      instructions: data['instructions'],
      thumbnail: data['thumbnail'],
      ingredients: List<String>.from(data['ingredients']),
      measures: List<String>.from(data['measures']),
      verificationStatus: data['verificationStatus'] ?? 'pending',
      verifiedBy: data['verifiedBy'],
      verifiedAt: (data['verifiedAt'] as Timestamp?),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'name': name,
    'category': category,
    'instructions': instructions,
    'thumbnail': thumbnail,
    'ingredients': ingredients,
    'measures': measures,
    'verification_status': verificationStatus,
    'verified_by': verifiedBy,
    'verified_at': verifiedAt,
  };
}
