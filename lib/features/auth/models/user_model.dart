class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final DateTime dob;
  final String phoneNumber;
  final String uid;
  final List<String> interests;
  final List<String> travelTypes;
  final String budget;

  final DateTime createdAt;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.uid,
    required this.interests,
    required this.travelTypes,
    required this.budget,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dob': dob.toIso8601String(),
      'phoneNumber': phoneNumber,
      'interests': interests,
      'travelTypes': travelTypes,
      'budget': budget,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      uid: documentId,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      dob: DateTime.parse(map['dob']),
      phoneNumber: map['phoneNumber'] ?? '',
      interests: List<String>.from(map['interests'] ?? []),
      travelTypes: List<String>.from(map['travelTypes'] ?? []),
      budget: map['budget'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}