import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_service.g.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  static const _lastThemeKey = 'last_played_theme';

  Future<void> saveLastTheme(String themeId) async {
    await _prefs.setString(_lastThemeKey, themeId);
  }

  String? getLastTheme() {
    return _prefs.getString(_lastThemeKey);
  }
}

// Use Riverpod to provide this service to our app
@riverpod
Future<LocalStorageService> localStorageService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return LocalStorageService(prefs);
}
