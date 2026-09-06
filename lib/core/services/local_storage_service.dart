import 'package:shared_preferences/shared_preferences.dart';


class LocalStorageService {
  static const _hasSeenIntroKey = 'has_seen_intro';

  static Future<bool> hasSeenIntro() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenIntroKey) ?? false;
  }

  static Future<void> markIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenIntroKey, true);
  }
}