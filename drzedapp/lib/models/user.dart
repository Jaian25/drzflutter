enum Privilege { User, Admin, Moderator }

class User {
  final String userId;
  final String name;
  final String mobile;
  final String email;
  final List<String> favourites;
  final String profileUri;
  final Privilege privilege;
  final DateTime dateCreated;
  final DateTime lastLogin;
  final bool isActive;
  final String bio;

  User({
    required this.userId,
    required this.name,
    required this.mobile,
    required this.email,
    required this.favourites,
    required this.profileUri,
    required this.privilege,
    required this.dateCreated,
    required this.lastLogin,
    required this.isActive,
    required this.bio,
  });

  // Convert User to Map (for Firebase)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'mobile': mobile,
      'email': email,
      'favourites': favourites,
      'profileUri': profileUri,
      'privilege': privilege.toString().split('.').last, // Store as string
      'dateCreated': dateCreated,
      'lastLogin': lastLogin,
      'isActive': isActive,
      'bio': bio,
    };
  }

  // Create User from Map (for Firebase)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      mobile: map['mobile'] ?? '',
      email: map['email'] ?? '',
      favourites: List<String>.from(map['favourites'] ?? []),
      profileUri: map['profileUri'] ?? '',
      privilege: Privilege.values.firstWhere(
        (e) => e.toString().split('.').last == map['privilege'],
        orElse: () => Privilege.User, // Default to User
      ),
      dateCreated: map['dateCreated'] ?? DateTime.now(),
      lastLogin: map['lastLogin'] ?? DateTime.now(),
      isActive: map['isActive'] ?? true,
      bio: map['bio'] ?? '',
    );
  }
}
