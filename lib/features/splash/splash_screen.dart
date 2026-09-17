import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/responsive_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = Responsive.screenWidth(context);
    final screenH = Responsive.screenHeight(context);
    final logoCircleSize = screenW * 0.35; // ~35% of screen width
    final iconSize = logoCircleSize * 0.5;
    final fs = Responsive.fontScale(context);

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.horizontalPadding(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: logoCircleSize,
                height: logoCircleSize,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryMedium.withValues(alpha: 0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Center(
                  child: Icon(
                    LucideIcons.recycle,
                    size: iconSize,
                    color: AppColors.primary,
                  ),
                ),
              ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
              SizedBox(height: screenH * 0.03),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppConstants.appName,
                  style: AppTypography.displayMedium.copyWith(
                    color: AppColors.surface,
                    letterSpacing: 1.2,
                    fontSize: 28 * fs,
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
              SizedBox(height: screenH * 0.012),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppConstants.appTagline,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    fontSize: 16 * fs,
                  ),
                ),
              ).animate().fadeIn(delay: 700.ms),
              SizedBox(height: screenH * 0.07),
              SizedBox(
                width: 32 * fs,
                height: 32 * fs,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryMedium),
                ),
              ).animate().fadeIn(delay: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }
}
