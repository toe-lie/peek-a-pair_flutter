import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:peek_a_pair/core/services/storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sound_service.g.dart';

enum SoundEffect {
  flip('assets/audio/sfx/flip.wav'),
  match('assets/audio/sfx/match.wav'),
  mismatch('assets/audio/sfx/mismatch.wav'),
  win('assets/audio/sfx/win.wav');
  // click('sfx/click.wav');

  const SoundEffect(this.path, {this.volume = 1.0});

  final String path;
  final double volume;
}

enum GameMusic {
  mainTheme('assets/audio/music/main_theme.mp3');
  // gameplayTheme('assets/audio/music/gameplay_theme.mp3', volume: 0.7);

  const GameMusic(this.path, {this.volume = 1.0});

  final String path;
  final double volume;
}

class SoundSettings {
  final bool isMuted;

  SoundSettings({this.isMuted = false});
}

@Riverpod(keepAlive: true)
class SoundService extends _$SoundService {
  final SoLoud _soLoud = SoLoud.instance;
  final Map<SoundEffect, AudioSource> _sfxSources = {};
  final Map<GameMusic, AudioSource> _musicSources = {};
  SoundHandle? _musicHandle;
  late LocalStorageService _storageService;
  GameMusic? _currentlyPlayingMusic;

  @override
  Future<SoundSettings> build() async {
    await _soLoud.init();

    for (final sfx in SoundEffect.values) {
      final source = await _soLoud.loadAsset(sfx.path);
      _sfxSources[sfx] = source;
    }
    for (final music in GameMusic.values) {
      final source = await _soLoud.loadAsset(music.path);
      _musicSources[music] = source;
    }
    _storageService = await ref.watch(localStorageServiceProvider.future);
    final isMuted = _storageService.getMuteState();
    if (isMuted) {
      _soLoud.setGlobalVolume(0);
    }

    ref.onDispose(() {
      dispose();
    });
    return SoundSettings(isMuted: isMuted);
  }

  void dispose() {
    _soLoud.deinit();
  }

  Future<void> toggleMute() async {
    final newMuteState = !state.value!.isMuted;
    await _storageService.saveMuteState(newMuteState);

    _soLoud.setGlobalVolume(newMuteState ? 0 : 1);

    state = AsyncValue.data(SoundSettings(isMuted: newMuteState));
  }

  void playSfx(SoundEffect sfx) {
    if (state.value?.isMuted ?? false) return;

    final source = _sfxSources[sfx];
    if (source != null) {
      _soLoud.play(source, volume: sfx.volume);
    }
  }

  Future<void> playMusic(GameMusic music) async {
    if (state.value?.isMuted ?? false) return;
    await stopMusic();
    final source = _musicSources[music];
    if (source != null) {
      _musicHandle = await _soLoud.play(
        source,
        looping: true,
        volume: music.volume,
      );
      _currentlyPlayingMusic = music;
    }
  }

  Future<void> stopMusic() async {
    if (_musicHandle != null) {
      await _soLoud.stop(_musicHandle!);
      _musicHandle = null;
    }
    _currentlyPlayingMusic = null;
  }

  void setMusicVolume(double volume) {
    if (_musicHandle != null) {
      _soLoud.setVolume(_musicHandle!, volume);
    }
  }

  void resumeMusicAfterBackground() {
    if (_currentlyPlayingMusic != null) {
      playMusic(_currentlyPlayingMusic!);
    }
  }
}
