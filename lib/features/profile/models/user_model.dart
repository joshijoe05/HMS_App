class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.contactNumber,
    required this.createdAt,
    required this.updatedAt,
  });
  final String id;
  final String email;
  final String fullName;
  final String role;
  final String contactNumber;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'fullName': fullName,
      'role': role,
      'contactNumber': contactNumber,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      role: map['role'] as String,
      contactNumber: map['contactNumber'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }
}
