import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/custom_button.dart';
import '../../core/utils/responsive_utils.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final screenW = Responsive.screenWidth(context);
    final circleSize = screenW * 0.35;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hp, vertical: 24 * fs),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: circleSize,
                height: circleSize,
                decoration: const BoxDecoration(
                  color: AppColors.techBlueLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.mapPin,
                  size: circleSize * 0.5,
                  color: AppColors.techBlue,
                ),
              ),
              SizedBox(height: 36 * fs),
              Text(
                'Enable Location Services',
                style: AppTypography.displayMedium.copyWith(fontSize: 24 * fs),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12 * fs),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hp * 0.5),
                child: Text(
                  'E-Kabaadi uses your location to match nearby collectors in real-time, show estimated arrival times, and calculate accurate pickup distances.',
                  style: AppTypography.bodyLarge.copyWith(fontSize: 16 * fs),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              CustomButton(
                text: 'Allow Location Access',
                onPressed: () => context.go('/role-selection'),
                icon: LucideIcons.navigation,
              ),
              SizedBox(height: 12 * fs),
              TextButton(
                onPressed: () => context.go('/role-selection'),
                child: Text(
                  'Enter Location Manually',
                  style: AppTypography.labelLarge.copyWith(color: AppColors.textMuted, fontSize: 14 * fs),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
