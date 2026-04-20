import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../main.dart' show appLocale;
import '../theme/app_theme.dart';
import '../services/alarm_service.dart';
import '../widgets/bottom_nav.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AlarmService _alarmService = AlarmService();
  AlarmSound _selectedSound = AlarmSound.siren;
  bool _vibrationEnabled = true;
  bool _wakelockEnabled = true;
  String? _customSoundPath;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final sound = await _alarmService.getSelectedSound();
    final vib = await _alarmService.getVibrationEnabled();
    final wake = await _alarmService.getWakelockEnabled();
    final customPath = await _alarmService.getCustomSoundPath();
    setState(() {
      _selectedSound = sound;
      _vibrationEnabled = vib;
      _wakelockEnabled = wake;
      _customSoundPath = customPath;
    });
  }

  Future<void> _selectSound(AlarmSound sound) async {
    await _alarmService.setSelectedSound(sound);
    if (sound != AlarmSound.custom) {
      await _alarmService.setCustomSoundPath('');
      setState(() {
        _selectedSound = sound;
        _customSoundPath = null;
      });
    } else {
      setState(() => _selectedSound = sound);
    }
  }

  Future<void> _pickCustomSound() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'ogg', 'm4a'],
    );
    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      await _alarmService.setCustomSoundPath(path);
      await _alarmService.setSelectedSound(AlarmSound.custom);
      setState(() {
        _customSoundPath = path;
        _selectedSound = AlarmSound.custom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
        backgroundColor: AppColors.surfaceContainerLow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                final l10n = AppLocalizations.of(context)!;
                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    _SectionHeader(title: l10n.settingsSectionAlarmSignal),

                    // Sirene
                    _SoundTile(
                      icon: Icons.campaign_outlined,
                      title: l10n.settingsSiren,
                      subtitle: l10n.settingsSirenSubtitle,
                      selected: _selectedSound == AlarmSound.siren,
                      onTap: () => _selectSound(AlarmSound.siren),
                    ),
                    const SizedBox(height: 8),

                    // Hundegebell
                    _SoundTile(
                      icon: Icons.pets,
                      title: l10n.settingsDog,
                      subtitle: l10n.settingsDogSubtitle,
                      selected: _selectedSound == AlarmSound.dog,
                      onTap: () => _selectSound(AlarmSound.dog),
                    ),
                    const SizedBox(height: 8),

                    // Eigene MP3
                    _SoundTile(
                      icon: Icons.audio_file_outlined,
                      title: l10n.settingsCustomFile,
                      subtitle: _customSoundPath != null
                          ? _customSoundPath!.split('/').last
                          : l10n.settingsCustomFileSubtitle,
                      selected: _selectedSound == AlarmSound.custom,
                      onTap: _pickCustomSound,
                    ),

                    const SizedBox(height: 32),
                    _SectionHeader(title: l10n.settingsSectionGeneral),

                    _SettingsTile(
                      title: l10n.settingsVibration,
                      subtitle: l10n.settingsVibrationSubtitle,
                      trailing: Switch(
                        value: _vibrationEnabled,
                        onChanged: (v) async {
                          await _alarmService.setVibrationEnabled(v);
                          setState(() => _vibrationEnabled = v);
                        },
                        activeColor: AppColors.primary,
                      ),
                    ),
                    _SettingsTile(
                      title: l10n.settingsKeepScreenOn,
                      subtitle: l10n.settingsKeepScreenOnSubtitle,
                      trailing: Switch(
                        value: _wakelockEnabled,
                        onChanged: (v) async {
                          await _alarmService.setWakelockEnabled(v);
                          setState(() => _wakelockEnabled = v);
                        },
                        activeColor: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 32),
                    _SectionHeader(title: l10n.settingsSectionLanguage),
                    _LanguageSelector(),

                    const SizedBox(height: 32),
                    _SectionHeader(title: l10n.settingsSectionApp),
                    _SettingsTile(
                      title: l10n.settingsVersion,
                      subtitle: l10n.settingsVersionValue,
                      trailing: null,
                    ),
                  ],
                );
              },
            ),
          ),
          const AppBottomNav(currentIndex: 1),
        ],
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector();

  static const _languages = [
    ('de', '🇩🇪  Deutsch'),
    ('en', '🇬🇧  English'),
    ('fr', '🇫🇷  Français'),
    ('it', '🇮🇹  Italiano'),
    ('es', '🇪🇸  Español'),
    ('nl', '🇳🇱  Nederlands'),
  ];

  Future<void> _setLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', code);
    appLocale.value = Locale(code);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: appLocale,
      builder: (context, locale, _) {
        final currentCode = locale?.languageCode ?? 'de';
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentCode,
              isExpanded: true,
              dropdownColor: AppColors.surfaceContainerHigh,
              icon: Icon(Icons.keyboard_arrow_down, color: AppColors.onSurfaceVariant),
              onChanged: (code) {
                if (code != null) _setLocale(code);
              },
              items: _languages.map((lang) {
                final code = lang.$1;
                final name = lang.$2;
                return DropdownMenuItem<String>(
                  value: code,
                  child: Text(
                    name,
                    style: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: code == currentCode
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: code == currentCode
                          ? AppColors.primary
                          : AppColors.onSurface,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _SoundTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _SoundTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryContainer.withOpacity(0.15)
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: selected ? AppColors.primaryContainer : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? AppColors.primary : AppColors.onSurfaceVariant,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: selected
                          ? AppColors.primary
                          : AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.workSans(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurfaceVariant,
          letterSpacing: 2.5,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;

  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.workSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.workSans(
                    fontSize: 12,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
