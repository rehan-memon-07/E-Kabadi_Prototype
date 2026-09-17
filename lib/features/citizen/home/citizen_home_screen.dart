import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/pickup_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class CitizenHomeScreen extends ConsumerWidget {
  const CitizenHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final pickupState = ref.watch(pickupProvider);
    final userName = authState.user?.name ?? 'Aarav Sharma';
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hp, vertical: 16 * fs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning, $userName 👋',
                          style: AppTypography.titleLarge.copyWith(fontSize: 22 * fs),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2 * fs),
                        Row(
                          children: [
                            Icon(LucideIcons.mapPin, size: Responsive.iconSize(context, 14), color: AppColors.primary),
                            SizedBox(width: 4 * fs),
                            Flexible(
                              child: Text(
                                'Sector 62, Noida, UP',
                                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 12 * fs),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8 * fs),
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10 * fs),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(LucideIcons.bell, color: AppColors.textPrimary, size: Responsive.iconSize(context, 22)),
                      ),
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 10 * fs,
                          height: 10 * fs,
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.surface, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24 * fs),

              // Active Pickup Live Tracker Banner (if any active)
              if (pickupState.activePickup != null) ...[
                CustomCard(
                  color: AppColors.techBlueLight,
                  border: Border.all(color: AppColors.techBlue, width: 1.5),
                  shadows: AppShadows.softBlueGlow,
                  onTap: () => context.push('/citizen/live-tracking'),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12 * fs),
                        decoration: const BoxDecoration(
                          color: AppColors.techBlue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(LucideIcons.truck, color: AppColors.surface, size: Responsive.iconSize(context, 22)),
                      ),
                      SizedBox(width: 14 * fs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Collector Ramesh is on the way!',
                              style: AppTypography.titleSmall.copyWith(color: AppColors.textPrimary, fontSize: 16 * fs),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2 * fs),
                            Text(
                              'ETA: 6 mins • 1.2 km away',
                              style: AppTypography.bodySmall.copyWith(color: AppColors.techBlue, fontSize: 12 * fs),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 4 * fs),
                      Icon(LucideIcons.chevronRight, color: AppColors.techBlue, size: Responsive.iconSize(context, 20)),
                    ],
                  ),
                ).animate().shimmer(duration: 1500.ms),
                SizedBox(height: 20 * fs),
              ],

              // Hero Action Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(p * 1.2),
                decoration: BoxDecoration(
                  gradient: AppColors.darkHeroGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: AppShadows.glowingGreen,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10 * fs, vertical: 5 * fs),
                      decoration: BoxDecoration(
                        color: AppColors.primaryMedium.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primaryMedium.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        '⚡ Instant Doorstep Pickup',
                        style: AppTypography.labelSmall.copyWith(color: AppColors.primaryMedium, fontSize: 11 * fs),
                      ),
                    ),
                    SizedBox(height: 14 * fs),
                    Text(
                      'Turn Unused Household\nScrap Into Cash',
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.surface,
                        fontSize: 22 * fs,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 8 * fs),
                    Text(
                      'Upload scrap photos, get instant AI price estimates & doorstep collection.',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primaryLight.withValues(alpha: 0.8),
                        fontSize: 14 * fs,
                      ),
                    ),
                    SizedBox(height: 20 * fs),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: '+ Sell Scrap',
                            onPressed: () => context.go('/citizen/sell'),
                            type: ButtonType.primary,
                            icon: LucideIcons.camera,
                          ),
                        ),
                        SizedBox(width: 12 * fs),
                        Expanded(
                          child: CustomButton(
                            text: 'Schedule',
                            onPressed: () => context.push('/citizen/schedule-pickup'),
                            type: ButtonType.secondary,
                            icon: LucideIcons.calendar,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
              SizedBox(height: 28 * fs),

              // Your Eco Impact Metrics (only Scrap Recycled + CO₂ Saved — no Eco Points)
              Text('Your Environmental Impact 🌿', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 12 * fs),
              Row(
                children: [
                  Expanded(
                    child: CustomCard(
                      padding: EdgeInsets.all(p * 0.8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8 * fs),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFDCFCE7), Color(0xFFBBF7D0)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(LucideIcons.scale, color: AppColors.primary, size: Responsive.iconSize(context, 22)),
                          ),
                          SizedBox(height: 12 * fs),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '12.5 kg',
                              style: AppTypography.titleLarge.copyWith(fontSize: 22 * fs),
                            ),
                          ),
                          Text(
                            'Scrap Recycled',
                            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.15, end: 0),
                  SizedBox(width: 12 * fs),
                  Expanded(
                    child: CustomCard(
                      padding: EdgeInsets.all(p * 0.8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8 * fs),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFD1FAE5), Color(0xFFA7F3D0)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(LucideIcons.leaf, color: AppColors.success, size: Responsive.iconSize(context, 22)),
                          ),
                          SizedBox(height: 12 * fs),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '23.4 kg',
                              style: AppTypography.titleLarge.copyWith(fontSize: 22 * fs),
                            ),
                          ),
                          Text(
                            'CO₂ Saved',
                            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.15, end: 0),
                ],
              ),
              SizedBox(height: 28 * fs),

              // Recent Activity Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text('Recent Pickups', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
                  ),
                  TextButton(
                    onPressed: () => context.go('/citizen/orders'),
                    child: Text('View All', style: AppTypography.labelLarge.copyWith(color: AppColors.primary, fontSize: 14 * fs)),
                  ),
                ],
              ),
              SizedBox(height: 8 * fs),

              CustomCard(
                onTap: () => context.push('/citizen/scrap-journey'),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(width: 12 * fs),
                      Container(
                        padding: EdgeInsets.all(12 * fs),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(LucideIcons.packageCheck, color: AppColors.primary, size: Responsive.iconSize(context, 22)),
                      ),
                      SizedBox(width: 14 * fs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Plastic & Cardboard Scrap',
                              style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2 * fs),
                            Text(
                              '18 Sep 2026 • Collector Ramesh Kumar',
                              style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8 * fs),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('+ ₹118', style: AppTypography.titleSmall.copyWith(color: AppColors.success, fontSize: 16 * fs)),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 300.ms),
            ],
          ),
        ),
      ),
    );
  }
}
