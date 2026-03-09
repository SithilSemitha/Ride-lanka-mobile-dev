class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final DateTime dob;
  final String phoneNumber;
  final String? uid;
  final DateTime createdAt = DateTime.now();

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    this.uid,
    required DateTime createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dob': dob.toIso8601String(),
      'phoneNumber': phoneNumber,
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
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
