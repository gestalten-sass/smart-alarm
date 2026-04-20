import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../services/alarm_service.dart';
import 'home_screen.dart';

class AlarmActiveScreen extends StatefulWidget {
  const AlarmActiveScreen({super.key});

  @override
  State<AlarmActiveScreen> createState() => _AlarmActiveScreenState();
}

class _AlarmActiveScreenState extends State<AlarmActiveScreen>
    with TickerProviderStateMixin {
  late AnimationController _flashController;
  late AnimationController _pulseController;
  late Animation<double> _flashAnimation;
  late Animation<double> _pulseAnimation;
  final AlarmService _alarmService = AlarmService();

  @override
  void initState() {
    super.initState();

    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _flashAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _flashController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flashController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _stopAlarm() async {
    await _alarmService.deactivate();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _flashAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border.all(
                  color: AppColors.alarmRed
                      .withOpacity(_flashAnimation.value * 0.6),
                  width: 3,
                ),
              ),
              child: child,
            );
          },
          child: Column(
            children: [
              // Status-Bar
              Container(
                width: double.infinity,
                color: AppColors.alarmRed,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: AnimatedBuilder(
                  animation: _flashAnimation,
                  builder: (context, _) {
                    return Opacity(
                      opacity: _flashAnimation.value,
                      child: Text(
                        l10n.alarmActiveBanner,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Großes Alarm-Icon
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: child,
                          );
                        },
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.alarmRedLight,
                                AppColors.alarmRed,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.alarmRed.withOpacity(0.6),
                                blurRadius: 80,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      Text(
                        l10n.alarmWord,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 56,
                          fontWeight: FontWeight.w700,
                          color: AppColors.alarmRedLight,
                          letterSpacing: 6,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        l10n.alarmActiveWord,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 56,
                          fontWeight: FontWeight.w700,
                          color: AppColors.alarmRed,
                          letterSpacing: 6,
                          height: 1.0,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        l10n.alarmTriggered,
                        style: GoogleFonts.workSans(
                          fontSize: 14,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 64),

                      // Stop-Button
                      GestureDetector(
                        onTap: _stopAlarm,
                        child: Container(
                          width: 200,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.outline,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              l10n.alarmStop,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
