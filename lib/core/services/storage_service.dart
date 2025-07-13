import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_service.g.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  static const _lastThemeKey = 'last_played_theme';

  final _progressUpdateController = StreamController<String>.broadcast();

  Future<void> saveLastTheme(String themeId) async {
    await _prefs.setString(_lastThemeKey, themeId);
  }

  String? getLastTheme() {
    return _prefs.getString(_lastThemeKey);
  }

  Future<void> saveLevelProgress(String levelId, int stars) async {
    await _prefs.setInt('level_${levelId}_stars', stars);
    _progressUpdateController.add(levelId);
  }

  int getLevelStars(String levelId) {
    return _prefs.getInt('level_${levelId}_stars') ?? 0;
  }

  Stream<int> watchLevelStars(String levelId) async* {
    yield getLevelStars(levelId);

    await for (final updatedLevelId in _progressUpdateController.stream) {
      if (updatedLevelId == levelId) {
        yield getLevelStars(levelId);
      }
    }
  }

  Stream<String> get onProgressUpdated => _progressUpdateController.stream;

  void dispose() {
    _progressUpdateController.close();
  }
}

@Riverpod(keepAlive: true)
Future<LocalStorageService> localStorageService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  final service = LocalStorageService(prefs);

  ref.onDispose(service.dispose);

  return service;
}

@riverpod
Stream<String> progressUpdates(Ref ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return storageService.when(
    data: (service) => service.onProgressUpdated,
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
}
