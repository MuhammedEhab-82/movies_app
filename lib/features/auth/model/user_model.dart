class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}