class UserProfile {
  String name;
  String avatarUrl;
  List<String>? watchlist;
  List<String>? history;

  UserProfile({
    required this.name,
    required this.avatarUrl,
    this.watchlist = const [],
    this.history = const [],
  });
}
