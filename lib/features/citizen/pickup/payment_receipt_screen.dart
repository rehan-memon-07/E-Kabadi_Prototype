import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../core/utils/responsive_utils.dart';

class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final screenW = Responsive.screenWidth(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0FDF4), AppColors.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(hp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Success icon with sparkle effect
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: screenW * 0.35,
                      height: screenW * 0.35,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ).animate(onPlay: (c) => c.repeat(reverse: true))
                     .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 2000.ms),
                    Container(
                      padding: EdgeInsets.all(28 * fs),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                        boxShadow: AppShadows.softGreenGlow,
                      ),
                      child: Icon(LucideIcons.checkCircle2, size: Responsive.iconSize(context, 64), color: AppColors.primary),
                    ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
                  ],
                ),
                SizedBox(height: 24 * fs),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Payment Received!',
                    style: AppTypography.displayMedium.copyWith(fontSize: 26 * fs, color: AppColors.primaryDark),
                  ),
                ),
                SizedBox(height: 6 * fs),
                Text(
                  'Direct UPI transfer completed successfully',
                  style: AppTypography.bodyLarge.copyWith(fontSize: 16 * fs),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12 * fs),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '₹118.00',
                    style: AppTypography.displayLarge.copyWith(fontSize: 40 * fs, color: AppColors.primary),
                  ),
                ).animate().fadeIn(delay: 300.ms),
                SizedBox(height: 32 * fs),

                // Transaction Receipt Card (dashed border style)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: AppShadows.card,
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Column(
                    children: [
                      // Dashed top accent
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Responsive.padding(context)),
                        child: Column(
                          children: [
                            _buildReceiptRow('Payment Method', 'UPI / Google Pay', fs),
                            const Divider(height: 20),
                            _buildReceiptRow('Transaction ID', 'TXN948102948', fs),
                            const Divider(height: 20),
                            _buildReceiptRow('Date & Time', 'Today, 11:45 AM', fs),
                            const Divider(height: 20),
                            _buildReceiptRow('Collector', 'Ramesh Kumar', fs),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                CustomButton(
                  text: 'Track Scrap Journey & Recycling',
                  onPressed: () => context.go('/citizen/scrap-journey'),
                  icon: LucideIcons.gitCommit,
                ),
                SizedBox(height: 12 * fs),
                CustomButton(
                  text: 'Done',
                  onPressed: () => context.go('/citizen/home'),
                  type: ButtonType.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, double fs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(label, style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs)),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
