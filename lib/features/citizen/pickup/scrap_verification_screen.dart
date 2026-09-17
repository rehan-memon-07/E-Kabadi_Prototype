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

class ScrapVerificationScreen extends ConsumerWidget {
  const ScrapVerificationScreen({super.key});

  void _onConfirmPayment(BuildContext context, WidgetRef ref) async {
    await ref.read(pickupProvider.notifier).completePickupAndPay(4.6, 118.0);
    if (context.mounted) {
      context.push('/citizen/payment-receipt');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Doorstep Scrap Verification'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Collector Verified Breakdown',
                style: AppTypography.titleLarge.copyWith(fontSize: 22 * fs),
              ),
              SizedBox(height: 6 * fs),
              Text(
                'Collector Ramesh verified material quality and weighed scrap using digital scales.',
                style: AppTypography.bodyMedium.copyWith(fontSize: 14 * fs),
              ),
              SizedBox(height: 24 * fs),

              // Side-by-side Comparison Card
              CustomCard(
                padding: EdgeInsets.all(p),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AI Estimate', style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs)),
                          SizedBox(height: 4 * fs),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('₹118.00', style: AppTypography.titleMedium.copyWith(color: AppColors.textMuted, fontSize: 18 * fs)),
                          ),
                          SizedBox(height: 2 * fs),
                          Text('Est. 4.6 kg', style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs)),
                        ],
                      ),
                    ),
                    Container(
                      height: 60 * fs,
                      width: 1,
                      margin: EdgeInsets.symmetric(horizontal: 8 * fs),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.border.withValues(alpha: 0), AppColors.primary, AppColors.border.withValues(alpha: 0)],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(LucideIcons.badgeCheck, size: Responsive.iconSize(context, 14), color: AppColors.primary),
                              SizedBox(width: 4 * fs),
                              Flexible(
                                child: Text(
                                  'Verified Final',
                                  style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontSize: 11 * fs),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4 * fs),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '₹118.00',
                              style: AppTypography.displayMedium.copyWith(fontSize: 24 * fs, color: AppColors.primary),
                            ),
                          ),
                          SizedBox(height: 2 * fs),
                          Text('Actual 4.6 kg', style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24 * fs),

              Text('Verified Itemized List', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 12 * fs),

              CustomCard(
                padding: EdgeInsets.all(p * 0.8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'PET Plastic Bottles (1.4 kg @ ₹50/kg)',
                            style: AppTypography.bodyMedium.copyWith(fontSize: 14 * fs),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8 * fs),
                        Text('₹70.00', style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs)),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Cardboard Boxes (3.2 kg @ ₹15/kg)',
                            style: AppTypography.bodyMedium.copyWith(fontSize: 14 * fs),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8 * fs),
                        Text('₹48.00', style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32 * fs),

              CustomButton(
                text: 'Accept Amount & Receive Payment',
                onPressed: () => _onConfirmPayment(context, ref),
                icon: LucideIcons.wallet,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
