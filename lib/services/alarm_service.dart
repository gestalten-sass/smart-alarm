import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:vibration/vibration.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AlarmSound { siren, dog, custom }

class AlarmService {
  static final AlarmService _instance = AlarmService._internal();
  factory AlarmService() => _instance;
  AlarmService._internal();

  final AudioPlayer _player = AudioPlayer();
  bool _isActive = false;
  double? _previousVolume;

  bool get isActive => _isActive;

  Future<AlarmSound> getSelectedSound() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('alarm_sound') ?? 0;
    return AlarmSound.values[index];
  }

  Future<void> setSelectedSound(AlarmSound sound) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('alarm_sound', sound.index);
  }

  Future<String?> getCustomSoundPath() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('custom_sound_path');
    return (path != null && path.isNotEmpty) ? path : null;
  }

  Future<void> setCustomSoundPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('custom_sound_path', path);
  }

  Future<bool> getVibrationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('vibration_enabled') ?? true;
  }

  Future<void> setVibrationEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('vibration_enabled', value);
  }

  Future<bool> getWakelockEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('wakelock_enabled') ?? true;
  }

  Future<void> setWakelockEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('wakelock_enabled', value);
  }

  Future<void> activate() async {
    _isActive = true;

    _previousVolume = await FlutterVolumeController.getVolume();
    await FlutterVolumeController.setVolume(1.0);

    final sound = await getSelectedSound();

    if (sound == AlarmSound.siren) {
      await _player.setVolume(1.0);
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.play(AssetSource('sounds/alarm_signal.mp3'));
    } else if (sound == AlarmSound.custom) {
      final path = await getCustomSoundPath();
      if (path != null) {
        await _player.setVolume(1.0);
        await _player.setReleaseMode(ReleaseMode.loop);
        await _player.play(DeviceFileSource(path));
      } else {
        await _player.setVolume(1.0);
        await _player.setReleaseMode(ReleaseMode.loop);
        await _player.play(AssetSource('sounds/alarm_signal.mp3'));
      }
    } else {
      await _player.setVolume(1.0);
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.play(AssetSource('sounds/dog_barking.mp3'));
    }

    final vibrationEnabled = await getVibrationEnabled();
    final wakelockEnabled = await getWakelockEnabled();

    if (wakelockEnabled) await WakelockPlus.enable();

    if (vibrationEnabled) {
      final hasVibrator = await Vibration.hasVibrator() ?? false;
      if (hasVibrator) {
        Vibration.vibrate(
          pattern: [0, 500, 200, 500, 200, 500],
          repeat: 0,
        );
      }
    }
  }

  Future<void> deactivate() async {
    _isActive = false;
    await _player.stop();
    if (_previousVolume != null) {
      await FlutterVolumeController.setVolume(_previousVolume!);
      _previousVolume = null;
    }
    await Vibration.cancel();
    await WakelockPlus.disable();
  }

  void dispose() {
    _player.dispose();
  }
}
