import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../shared/widgets/custom_card.dart';
import '../../core/utils/responsive_utils.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  void _selectRole(BuildContext context, WidgetRef ref, UserRole role) async {
    await ref.read(authProvider.notifier).setRole(role);
    if (context.mounted) {
      if (role == UserRole.citizen) {
        context.go('/citizen/home');
      } else {
        context.go('/collector/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final iconCircleSize = Responsive.isSmallScreen(context) ? 56.0 : 68.0;
    final roleIconSize = Responsive.isSmallScreen(context) ? 28.0 : 36.0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hp, vertical: 24 * fs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20 * fs),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8 * fs),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(LucideIcons.recycle, size: Responsive.iconSize(context, 24), color: AppColors.primary),
                  ),
                  SizedBox(width: 10 * fs),
                  Flexible(
                    child: Text(
                      'E-Kabaadi',
                      style: AppTypography.titleLarge.copyWith(color: AppColors.primaryDark, fontSize: 22 * fs),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36 * fs),
              Text(
                'Who are you?',
                style: AppTypography.displayMedium.copyWith(fontSize: 28 * fs),
              ),
              SizedBox(height: 8 * fs),
              Text(
                'Select your profile experience to continue inside the application.',
                style: AppTypography.bodyLarge.copyWith(fontSize: 16 * fs),
              ),
              SizedBox(height: 32 * fs),

              // Option 1: CITIZEN
              CustomCard(
                padding: EdgeInsets.all(Responsive.padding(context)),
                border: Border.all(color: AppColors.primary, width: 2),
                onTap: () => _selectRole(context, ref, UserRole.citizen),
                child: Row(
                  children: [
                    Container(
                      width: iconCircleSize,
                      height: iconCircleSize,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(LucideIcons.home, size: roleIconSize, color: AppColors.primary),
                      ),
                    ),
                    SizedBox(width: 16 * fs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'I am a Citizen',
                                  style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(LucideIcons.arrowRight, size: Responsive.iconSize(context, 20), color: AppColors.primary),
                            ],
                          ),
                          SizedBox(height: 4 * fs),
                          Text(
                            'Sell household scrap, AI estimation & schedule home pickups.',
                            style: AppTypography.bodyMedium.copyWith(fontSize: 14 * fs),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20 * fs),

              // Option 2: SCRAP COLLECTOR
              CustomCard(
                padding: EdgeInsets.all(Responsive.padding(context)),
                border: Border.all(color: AppColors.techBlue, width: 2),
                onTap: () => _selectRole(context, ref, UserRole.collector),
                child: Row(
                  children: [
                    Container(
                      width: iconCircleSize,
                      height: iconCircleSize,
                      decoration: const BoxDecoration(
                        color: AppColors.techBlueLight,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(LucideIcons.truck, size: roleIconSize, color: AppColors.techBlue),
                      ),
                    ),
                    SizedBox(width: 16 * fs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'I am a Scrap Collector',
                                  style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(LucideIcons.arrowRight, size: Responsive.iconSize(context, 20), color: AppColors.techBlue),
                            ],
                          ),
                          SizedBox(height: 4 * fs),
                          Text(
                            'Receive nearby pickup requests, navigate, collect & earn Eco Coins.',
                            style: AppTypography.bodyMedium.copyWith(fontSize: 14 * fs),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  'You can switch roles anytime in Profile Settings.',
                  style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
