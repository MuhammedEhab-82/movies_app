import 'package:movies_app/core/utils/app_assets.dart';

class UserModel {
  static const String collectionName = 'users';

  String id;
  String name;
  String phone;
  String avatarUrl;
  String? email;
  List<String> watchlist;
  List<String> history;

  UserModel({
    String? id,
    String? uid,
    required this.phone,
    required this.name,
    String? avatarUrl,
    int? avatar,
    this.watchlist = const [],
    this.history = const [],
    this.email,
  })  : id = id ?? uid ?? '',
        avatarUrl = avatarUrl ?? AppImages.avatarByIndex(avatar ?? 1);

  UserModel.fromMap(Map<String, dynamic> data)
      : this(
          id: data['id'] ?? data['uid'],
          uid: data['uid'],
          name: (data['name'] ?? '') as String,
          email: data['email'] as String?,
          phone: (data['phone'] ?? '') as String,
          avatarUrl: data['avatarUrl'] as String?,
          avatar: data['avatar'] as int?,
          watchlist: List<String>.from(data['watchlist'] ?? []),
          history: List<String>.from(data['history'] ?? []),
        );

  UserModel.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['uid'] as String? ?? data['id'] as String? ?? '',
          uid: data['uid'] as String?,
          name: data['name'] as String? ?? '',
          email: data['email'] as String?,
          phone: data['phone'] as String? ?? '',
          avatarUrl: data['avatarUrl'] as String?,
          avatar: data['avatar'] as int?,
          watchlist: List<String>.from(data['watchlist'] ?? []),
          history: List<String>.from(data['history'] ?? []),
        );

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': AppImages.indexByAvatar(avatarUrl),
      'avatarUrl': avatarUrl,
      'watchlist': watchlist,
      'history': history,
    };
  }

  Map<String, dynamic> toFireStore() {
    return toMap();
  }
}