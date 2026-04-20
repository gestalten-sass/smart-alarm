import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: AppColors.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.shield_outlined,
            label: l10n.navCentral,
            active: currentIndex == 0,
            onTap: currentIndex == 0
                ? () {}
                : () => Navigator.of(context).pop(),
          ),
          _NavItem(
            icon: Icons.settings_outlined,
            label: l10n.navSettings,
            active: currentIndex == 1,
            onTap: currentIndex == 1
                ? () {}
                : currentIndex == 0
                    ? () => Navigator.of(context).pushNamed('/settings')
                    : () => Navigator.of(context).pushReplacementNamed('/settings'),
          ),
          _NavItem(
            icon: Icons.info_outline,
            label: l10n.navInfo,
            active: currentIndex == 2,
            onTap: currentIndex == 2
                ? () {}
                : currentIndex == 0
                    ? () => Navigator.of(context).pushNamed('/info')
                    : () => Navigator.of(context).pushReplacementNamed('/info'),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: active ? AppColors.onSurface : AppColors.onSurfaceVariant,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.workSans(
              fontSize: 11,
              color: active ? AppColors.onSurface : AppColors.onSurfaceVariant,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
