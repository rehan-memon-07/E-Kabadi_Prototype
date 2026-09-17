import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../providers/rewards_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class EcoRewardsScreen extends ConsumerWidget {
  const EcoRewardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final couponsAsync = ref.watch(availableCouponsProvider);
    final historyAsync = ref.watch(citizenPointHistoryProvider);
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Eco Rewards & Badges', showBack: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Points Card
              Container(
                padding: EdgeInsets.all(p * 1.2),
                decoration: BoxDecoration(
                  gradient: AppColors.rewardGradient,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Your Eco Points Balance',
                            style: AppTypography.titleSmall.copyWith(
                              color: AppColors.surface.withValues(alpha: 0.9),
                              fontSize: 16 * fs,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8 * fs),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10 * fs, vertical: 4 * fs),
                            decoration: BoxDecoration(
                              color: AppColors.surface.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Level: Recycler 🌿',
                              style: AppTypography.labelSmall.copyWith(color: AppColors.surface, fontSize: 11 * fs),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12 * fs),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(LucideIcons.award, size: Responsive.iconSize(context, 40), color: AppColors.surface),
                          SizedBox(width: 12 * fs),
                          Text(
                            '840',
                            style: AppTypography.displayLarge.copyWith(color: AppColors.surface, fontSize: 44 * fs),
                          ),
                          SizedBox(width: 8 * fs),
                          Text('PTS', style: AppTypography.titleMedium.copyWith(color: AppColors.surface, fontSize: 18 * fs)),
                        ],
                      ),
                    ),
                    SizedBox(height: 16 * fs),

                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0.84,
                        minHeight: 8,
                        backgroundColor: Colors.white30,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.surface),
                      ),
                    ),
                    SizedBox(height: 8 * fs),
                    Text(
                      '160 points away from Green Hero level badge',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.surface.withValues(alpha: 0.9), fontSize: 12 * fs),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28 * fs),

              // Redeem Vouchers Section
              Text('Redeem Rewards & Coupons', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 12 * fs),

              couponsAsync.when(
                data: (coupons) => Column(
                  children: coupons.map((c) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12 * fs),
                      child: CustomCard(
                        padding: EdgeInsets.all(p * 0.8),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12 * fs),
                              decoration: const BoxDecoration(
                                color: AppColors.rewardOrangeLight,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(LucideIcons.ticket, color: AppColors.rewardOrange, size: Responsive.iconSize(context, 24)),
                            ),
                            SizedBox(width: 14 * fs),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    c.title,
                                    style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2 * fs),
                                  Text(
                                    c.description,
                                    style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4 * fs),
                                  Text(
                                    '${c.pointsCost} Points Required',
                                    style: AppTypography.labelSmall.copyWith(color: AppColors.rewardOrange, fontSize: 11 * fs),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8 * fs),
                            CustomButton(
                              text: 'Redeem',
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Redeemed ${c.title}! Coupon code: ${c.couponCode}')),
                                );
                              },
                              type: ButtonType.secondary,
                              width: 80 * fs,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Text('Error loading coupons: $e'),
              ),
              SizedBox(height: 24 * fs),

              // Points History List
              Text('Points Transaction History', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 12 * fs),

              historyAsync.when(
                data: (history) => Column(
                  children: history.map((item) {
                    final isEarned = item.type == 'earned';
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10 * fs),
                      child: CustomCard(
                        padding: EdgeInsets.all(p * 0.7),
                        child: Row(
                          children: [
                            Icon(
                              isEarned ? LucideIcons.arrowUpRight : LucideIcons.arrowDownLeft,
                              color: isEarned ? AppColors.success : AppColors.error,
                              size: Responsive.iconSize(context, 20),
                            ),
                            SizedBox(width: 12 * fs),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    item.description,
                                    style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8 * fs),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${isEarned ? "+" : "-"}${item.points} pts',
                                  style: AppTypography.titleSmall.copyWith(
                                    color: isEarned ? AppColors.success : AppColors.error,
                                    fontSize: 16 * fs,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                loading: () => const SizedBox(),
                error: (e, s) => const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
