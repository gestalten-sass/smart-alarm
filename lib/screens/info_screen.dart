import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      setState(() => _version = info.version);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.infoTitle),
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
          // Wichtiger Hinweis — kein Notruf
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A1A00),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color(0xFFE65100).withOpacity(0.7),
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFFF8F00),
                  size: 28,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.infoNoEmergencyTitle,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF8F00),
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.infoNoEmergencyBody,
                        style: GoogleFonts.workSans(
                          fontSize: 13,
                          color: const Color(0xFFFFCC80),
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Was ist SmartAlarm
          _InfoHeader(title: l10n.infoWhatIsTitle),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              l10n.infoWhatIsBody,
              style: GoogleFonts.workSans(
                fontSize: 13,
                color: AppColors.onSurfaceVariant,
                height: 1.7,
              ),
            ),
          ),

          const SizedBox(height: 24),

          _InfoHeader(title: l10n.infoUseCasesTitle),
          _InfoCard(
            icon: Icons.directions_car_outlined,
            title: l10n.infoUseCaseRvTitle,
            body: l10n.infoUseCaseRvBody,
          ),
          _InfoCard(
            icon: Icons.hiking_outlined,
            title: l10n.infoUseCaseOutdoorTitle,
            body: l10n.infoUseCaseOutdoorBody,
          ),
          _InfoCard(
            icon: Icons.people_outline,
            title: l10n.infoUseCasePublicTitle,
            body: l10n.infoUseCasePublicBody,
          ),
          _InfoCard(
            icon: Icons.elderly_outlined,
            title: l10n.infoUseCaseSeniorsTitle,
            body: l10n.infoUseCaseSeniorsBody,
          ),

          const SizedBox(height: 24),

          _InfoHeader(title: l10n.infoHowItWorksTitle),
          _InfoCard(
            icon: Icons.touch_app_outlined,
            title: l10n.infoHowTriggerTitle,
            body: l10n.infoHowTriggerBody,
          ),
          _InfoCard(
            icon: Icons.volume_up_outlined,
            title: l10n.infoHowVolumeTitle,
            body: l10n.infoHowVolumeBody,
          ),
          _InfoCard(
            icon: Icons.audio_file_outlined,
            title: l10n.infoHowSoundTitle,
            body: l10n.infoHowSoundBody,
          ),
          _InfoCard(
            icon: Icons.stop_circle_outlined,
            title: l10n.infoHowStopTitle,
            body: l10n.infoHowStopBody,
          ),

          const SizedBox(height: 24),

          _InfoHeader(title: l10n.infoWhyOfflineTitle),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              l10n.infoWhyOfflineBody,
              style: GoogleFonts.workSans(
                fontSize: 13,
                color: AppColors.onSurfaceVariant,
                height: 1.7,
              ),
            ),
          ),

          const SizedBox(height: 24),

          _InfoHeader(title: l10n.infoPrivacyTitle),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              l10n.infoPrivacyBody,
              style: GoogleFonts.workSans(
                fontSize: 13,
                color: AppColors.onSurfaceVariant,
                height: 1.7,
              ),
            ),
          ),

          const SizedBox(height: 24),

          _InfoHeader(title: l10n.infoAppInfoTitle),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                _InfoRow(label: l10n.settingsVersion, value: _version),
                _InfoRow(label: l10n.infoDeveloper, value: 'Gestalten Sass'),
                _InfoRow(label: l10n.infoPlatform, value: 'Android'),
              ],
            ),
          ),
                ],
              );
            },
          ),
          ),
          const AppBottomNav(currentIndex: 2),
        ],
      ),
    );
  }
}

class _InfoHeader extends StatelessWidget {
  final String title;
  const _InfoHeader({required this.title});

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

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.workSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: GoogleFonts.workSans(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.workSans(
              fontSize: 13,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.workSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
