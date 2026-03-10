class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String dob;
  final String phone;

  final List<String> interests;
  final String travelType;
  final String budget;

  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.phone,
    required this.interests,
    required this.travelType,
    required this.budget,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "dob": dob,
      "phone": phone,
      "preferences": {
        "interests": interests,
        "travelType": travelType,
        "budget": budget,
      },
      "createdAt": createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      firstName: map["firstName"],
      lastName: map["lastName"],
      email: map["email"],
      dob: map["dob"],
      phone: map["phone"],
      interests: List<String>.from(map["preferences"]["interests"]),
      travelType: map["preferences"]["travelType"],
      budget: map["preferences"]["budget"],
      createdAt: map["createdAt"].toDate(),
    );
  }
}