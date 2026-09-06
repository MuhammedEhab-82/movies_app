import 'package:movies_app/core/utils/app_assets.dart';

class UserProfile {
  static const String collectionName = 'users';

  String name;
  String id;
  String phone;
  String avatarUrl;
  String? email;
  List<String> watchlist;
  List<String> history;
  bool? isFavourite;

  UserProfile({
    required this.id,
    required this.phone,
    required this.name,
    required this.avatarUrl,
    this.watchlist = const [],
    this.history = const [],
    this.email,
    this.isFavourite
  });

  /// json => obj
  UserProfile.fromFireStore(Map<String, dynamic> data)
      : this(
    id: data['uid'] as String,
    name: data['name'] as String,
    email: data['email'] as String?,
    phone: data['phone'] as String,
    avatarUrl: AppImages.avatarByIndex(
      data['avatar'] as int? ?? 1,
    ),
    watchlist: List<String>.from(data['watchlist'] ?? []),
    history: List<String>.from(data['history'] ?? []),
    isFavourite: data['isFavourite']
  );

  /// object => json
  Map<String, dynamic> toFireStore() {
    return {
      'uid': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': AppImages.indexByAvatar(avatarUrl),
      'watchlist': watchlist,
      'history': history,
      'isFavourite' : isFavourite
    };
  }
}