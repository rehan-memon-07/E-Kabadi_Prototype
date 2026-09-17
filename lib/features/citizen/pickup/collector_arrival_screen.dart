import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../providers/pickup_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class CollectorArrivalScreen extends ConsumerWidget {
  const CollectorArrivalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickupState = ref.watch(pickupProvider);
    final active = pickupState.activePickup;
    final otpCode = active?.otpCode ?? '4829';
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);
    final screenW = Responsive.screenWidth(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Collector Arrived'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(hp),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24 * fs),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.truck, size: Responsive.iconSize(context, 64), color: AppColors.primary),
              ),
              SizedBox(height: 24 * fs),
              Text(
                'Your collector has arrived!',
                style: AppTypography.displayMedium.copyWith(fontSize: 24 * fs),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8 * fs),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hp * 0.5),
                child: Text(
                  'Verify the collector identity & share the OTP before handing over scrap.',
                  style: AppTypography.bodyLarge.copyWith(fontSize: 16 * fs),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32 * fs),

              // Collector Verification Card
              CustomCard(
                padding: EdgeInsets.all(p),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30 * fs,
                      backgroundColor: AppColors.primaryDark,
                      child: Text('RK', style: AppTypography.titleLarge.copyWith(color: AppColors.surface, fontSize: 22 * fs)),
                    ),
                    SizedBox(width: 16 * fs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Ramesh Kumar',
                                  style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 6 * fs),
                              Icon(LucideIcons.badgeCheck, size: Responsive.iconSize(context, 18), color: AppColors.techBlue),
                            ],
                          ),
                          SizedBox(height: 4 * fs),
                          Text('ID: COL-EK-892', style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs)),
                          Text(
                            'Verified E-Kabaadi Partner',
                            style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontSize: 11 * fs),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28 * fs),

              // Share OTP Code Box
              Container(
                padding: EdgeInsets.all(p),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: Column(
                  children: [
                    Text('Share Verification OTP', style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs)),
                    SizedBox(height: 8 * fs),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: otpCode.split('').map((digit) {
                          final digitPadH = screenW < 360 ? 12.0 : 16.0;
                          final digitPadV = screenW < 360 ? 8.0 : 12.0;
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 6 * fs),
                            padding: EdgeInsets.symmetric(horizontal: digitPadH * fs, vertical: digitPadV * fs),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              digit,
                              style: AppTypography.displayMedium.copyWith(color: AppColors.primary, fontSize: 28 * fs),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              CustomButton(
                text: 'Verify Scrap & Calculate Price',
                onPressed: () => context.push('/citizen/scrap-verification'),
                icon: LucideIcons.scale,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
