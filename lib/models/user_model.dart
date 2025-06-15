import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { regular, chef }

class AppUser {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? bio;
  final DateTime createdAt;
  final List<String> favoriteCategories;
  final UserRole role;
  // Chef-specific fields
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? chefBio;
  final List<String>? specialties;
  final bool isVerified;

  AppUser({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.bio,
    required this.createdAt,
    required this.favoriteCategories,
    this.role = UserRole.regular,
    this.firstName,
    this.middleName,
    this.lastName,
    this.chefBio,
    this.specialties,
    this.isVerified = false,
  });

  factory AppUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return AppUser(
      uid: snapshot.id,
      email: data['email'],
      displayName: data['displayName'],
      photoUrl: data['photoUrl'],
      bio: data['bio'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      favoriteCategories: List<String>.from(data['favoriteCategories']),
      role: UserRole.values.byName(data['role'] ?? 'regular'),
      firstName: data['firstName'],
      middleName: data['middleName'],
      lastName: data['lastName'],
      chefBio: data['chefBio'],
      specialties: data['specialties'] != null
          ? List<String>.from(data['specialties'])
          : null,
      isVerified: data['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'bio': bio,
      'createdAt': Timestamp.fromDate(createdAt),
      'favoriteCategories': favoriteCategories,
      'role': role.name,
      if (role == UserRole.chef) ...{
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'chefBio': chefBio,
        'specialties': specialties,
      },
      'isVerified': isVerified,
    };
  }
}
