import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../providers/collector_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class CollectorVerificationScreen extends ConsumerStatefulWidget {
  const CollectorVerificationScreen({super.key});

  @override
  ConsumerState<CollectorVerificationScreen> createState() => _CollectorVerificationScreenState();
}

class _CollectorVerificationScreenState extends ConsumerState<CollectorVerificationScreen> {
  final TextEditingController _otpController = TextEditingController(text: '4829');
  final TextEditingController _weightController = TextEditingController(text: '4.6');
  final TextEditingController _amountController = TextEditingController(text: '118.00');

  void _onCompleteCollection() {
    final weight = double.tryParse(_weightController.text) ?? 4.6;
    final amount = double.tryParse(_amountController.text) ?? 118.0;

    ref.read(collectorProvider.notifier).completeCollection(weight, amount);

    final fs = Responsive.fontScale(context);
    final p = Responsive.padding(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20 * fs),
              decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
              child: Icon(LucideIcons.checkCircle2, color: AppColors.primary, size: Responsive.iconSize(context, 48)),
            ),
            SizedBox(height: 16 * fs),
            Text(
              'Collection Completed!',
              style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8 * fs),
            Text(
              'Citizen payment of ₹${amount.toStringAsFixed(0)} processed via UPI.',
              style: AppTypography.bodyMedium.copyWith(fontSize: 14 * fs),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12 * fs),
            Container(
              padding: EdgeInsets.all(12 * fs),
              decoration: BoxDecoration(color: AppColors.rewardOrangeLight, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Icon(LucideIcons.coins, color: AppColors.rewardOrange, size: Responsive.iconSize(context, 24)),
                  SizedBox(width: 10 * fs),
                  Expanded(
                    child: Text(
                      '+150 Eco Coins Earned!',
                      style: AppTypography.titleSmall.copyWith(color: AppColors.rewardOrange, fontSize: 16 * fs),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20 * fs),
            CustomButton(
              text: 'Back to Dashboard',
              onPressed: () {
                Navigator.pop(context);
                context.go('/collector/dashboard');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Verify & Weigh Scrap'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Handshake OTP Verification', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 8 * fs),
              Text(
                'Ask the citizen for their 4-digit verification code to confirm pickup start.',
                style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
              ),
              SizedBox(height: 12 * fs),

              CustomTextField(
                label: 'Citizen OTP Code',
                hint: '4829',
                controller: _otpController,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(LucideIcons.key, color: AppColors.primary),
              ),
              SizedBox(height: 24 * fs),

              Text('Scrap Weighing & Pricing', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 12 * fs),

              CustomCard(
                padding: EdgeInsets.all(p * 0.9),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'Actual Weight (kg)',
                            hint: '4.6',
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            prefixIcon: const Icon(LucideIcons.scale, color: AppColors.textMuted),
                          ),
                        ),
                        SizedBox(width: 14 * fs),
                        Expanded(
                          child: CustomTextField(
                            label: 'Final Payout (₹)',
                            hint: '118.00',
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            prefixIcon: const Icon(LucideIcons.indianRupee, color: AppColors.textMuted),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14 * fs),
                    Text(
                      'AI Suggested Rate: ₹70 (Plastic) + ₹48 (Paper) = ₹118.00',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.primary, fontSize: 12 * fs),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32 * fs),

              CustomButton(
                text: 'Confirm Collection & Send Payment',
                onPressed: _onCompleteCollection,
                icon: LucideIcons.checkCircle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
