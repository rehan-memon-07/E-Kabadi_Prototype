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

class EcoCoinsScreen extends ConsumerWidget {
  const EcoCoinsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coinHistoryAsync = ref.watch(collectorCoinHistoryProvider);
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Collector Eco Coins & Marketplace', showBack: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Collector Hero Coin Balance Card
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
                            'Collector Eco Coins',
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
                              'Collector Tier: Gold 🏆',
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
                          Icon(LucideIcons.coins, size: Responsive.iconSize(context, 40), color: AppColors.surface),
                          SizedBox(width: 12 * fs),
                          Text(
                            '1,250',
                            style: AppTypography.displayLarge.copyWith(color: AppColors.surface, fontSize: 44 * fs),
                          ),
                          SizedBox(width: 8 * fs),
                          Text('COINS', style: AppTypography.titleMedium.copyWith(color: AppColors.surface, fontSize: 18 * fs)),
                        ],
                      ),
                    ),
                    SizedBox(height: 12 * fs),
                    Text(
                      'Earn Eco Coins on every pickup to redeem ration, healthcare & tools.',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.surface.withValues(alpha: 0.9), fontSize: 12 * fs),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28 * fs),

              // Collector Marketplace Section
              Text('Collector Benefit Marketplace 🏬', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 12 * fs),

              _buildBenefitCard(
                context,
                fs: fs,
                p: p,
                title: 'Monthly Household Ration Kit',
                subtitle: 'Includes 10kg Atta, 5kg Basmati Rice, 2L Oil & Pulses.',
                coins: 500,
                icon: LucideIcons.shoppingBag,
              ),
              _buildBenefitCard(
                context,
                fs: fs,
                p: p,
                title: 'Free Family Healthcare Voucher',
                subtitle: 'Valid for full body health checkup at Apollo Clinic.',
                coins: 300,
                icon: LucideIcons.stethoscope,
              ),
              _buildBenefitCard(
                context,
                fs: fs,
                p: p,
                title: 'Heavy Duty Gloves & Digital Scale',
                subtitle: 'Professional 100kg digital scale + Kevlar grip gloves.',
                coins: 400,
                icon: LucideIcons.wrench,
              ),
              SizedBox(height: 24 * fs),

              // Transaction History
              Text('Coin Transactions', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 12 * fs),

              coinHistoryAsync.when(
                data: (history) => Column(
                  children: history.map((item) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10 * fs),
                      child: CustomCard(
                        padding: EdgeInsets.all(p * 0.7),
                        child: Row(
                          children: [
                            Icon(
                              item.isCredit ? LucideIcons.plusCircle : LucideIcons.minusCircle,
                              color: item.isCredit ? AppColors.success : AppColors.error,
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
                                  '${item.isCredit ? "+" : "-"}${item.coins} coins',
                                  style: AppTypography.titleSmall.copyWith(
                                    color: item.isCredit ? AppColors.success : AppColors.error,
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

  Widget _buildBenefitCard(
    BuildContext context, {
    required double fs,
    required double p,
    required String title,
    required String subtitle,
    required int coins,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * fs),
      child: CustomCard(
        padding: EdgeInsets.all(p * 0.8),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12 * fs),
              decoration: const BoxDecoration(color: AppColors.rewardOrangeLight, shape: BoxShape.circle),
              child: Icon(icon, color: AppColors.rewardOrange, size: Responsive.iconSize(context, 24)),
            ),
            SizedBox(width: 14 * fs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2 * fs),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4 * fs),
                  Text(
                    '$coins Eco Coins',
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
                  SnackBar(content: Text('Successfully redeemed "$title"!')),
                );
              },
              type: ButtonType.secondary,
              width: 80 * fs,
            ),
          ],
        ),
      ),
    );
  }
}
