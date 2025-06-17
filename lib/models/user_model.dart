import "package:cloud_firestore/cloud_firestore.dart";

enum UserRole { regular, chef }

class RegularUser {
  final String uid;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String displayName;
  final String? photoUrl;
  final UserRole role;
  final String? bio;
  final List<String>? favourites;
  final Timestamp createdAt;

  RegularUser({
    required this.uid,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.role = UserRole.regular,
    this.bio,
    this.favourites,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  factory RegularUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return RegularUser(
      uid: snapshot.id,
      firstName: data["first_name"],
      middleName: data["middle_name"],
      lastName: data["last_name"],
      email: data["email"],
      displayName: data["display_name"],
      photoUrl: data["photo_url"],
      role: UserRole.values.byName(data["role"]),
      bio: data["bio"],
      favourites: List<String>.from(data["favoriteCategories"]),
      createdAt: (data["createdAt"] as Timestamp),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "email": email,
      "displayName": displayName,
      "photoUrl": photoUrl,
      "role": role.name,
      "bio": bio,
      "favoriteCategories": favourites,
      "createdAt": createdAt,
    };
  }
}

class ChefUser {
  final String uid;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String displayName;
  final String? photoUrl;
  final UserRole role;
  final String? bio;
  final List<String>? specialties; // TODO: Conver to enum
  final List<String>? favourites;
  final bool isVerified;
  final Timestamp createdAt;

  ChefUser({
    required this.uid,
    this.favourites,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.role = UserRole.chef,
    this.bio,
    this.specialties,
    this.isVerified = false,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  factory ChefUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions options,
  ) {
    final data = snapshot.data()!;
    return ChefUser(
      uid: snapshot.id,
      firstName: data["first_name"],
      middleName: data["middle_name"],
      lastName: data["last_name"],
      email: data["email"],
      displayName: data["display_name"],
      photoUrl: data["photo_url"],
      role: UserRole.values.byName(data["role"]),
      bio: data["bio"],
      specialties: data["specialties"] != null
          ? List<String>.from(data["specialties"])
          : null,
      favourites: List<String>.from(data["favoriteCategories"]),
      isVerified: data["is_verified"] ?? false,
      createdAt: (data["createdAt"] as Timestamp),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "email": email,
      "displayName": displayName,
      "photoUrl": photoUrl,
      "role": role.name,
      "bio": bio,
      "specialties": specialties,
      "favoriteCategories": favourites,
      "is_verified": isVerified,
      "createdAt": createdAt,
    };
  }
}
