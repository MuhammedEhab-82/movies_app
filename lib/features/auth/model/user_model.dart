class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final int avatar;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.avatar = 1,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    int? avatar,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      avatar: map['avatar'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
    };
  }
}