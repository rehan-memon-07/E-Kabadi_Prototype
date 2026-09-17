import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../providers/scrap_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class AiAnalysisScreen extends ConsumerWidget {
  const AiAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanState = ref.watch(scrapScanProvider);
    final screenW = Responsive.screenWidth(context);
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'AI Scrap Classification'),
      body: SafeArea(
        child: scanState.isAnalyzing
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: hp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(Responsive.padding(context) * 1.6),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(LucideIcons.scanLine, size: Responsive.iconSize(context, 64), color: AppColors.primary),
                      ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1)),
                      SizedBox(height: 24 * fs),
                      Text(
                        'AI Computer Vision Scanning...',
                        style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8 * fs),
                      Text(
                        'Detecting polymers, density, and market rates',
                        style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.all(hp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AI Scan Visualization — replaces personal image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: screenW * 0.55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: AppColors.darkHeroGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            // Background pattern circles
                            Positioned(
                              top: -20,
                              right: -20,
                              child: Container(
                                width: screenW * 0.35,
                                height: screenW * 0.35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryMedium.withValues(alpha: 0.08),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -30,
                              left: -15,
                              child: Container(
                                width: screenW * 0.25,
                                height: screenW * 0.25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryMedium.withValues(alpha: 0.06),
                                ),
                              ),
                            ),
                            // Center AI scan flow
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: hp),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Top row: Model → Gemini → Verifies
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // Scrap icon
                                        Container(
                                          padding: EdgeInsets.all(10 * fs),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryMedium.withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: AppColors.primaryMedium.withValues(alpha: 0.3)),
                                          ),
                                          child: Icon(LucideIcons.package, size: Responsive.iconSize(context, 28), color: AppColors.primaryMedium),
                                        ),
                                        SizedBox(width: 8 * fs),
                                        Icon(LucideIcons.arrowRight, size: Responsive.iconSize(context, 18), color: AppColors.primaryMedium.withValues(alpha: 0.6)),
                                        SizedBox(width: 8 * fs),
                                        // AI Brain
                                        Container(
                                          padding: EdgeInsets.all(10 * fs),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryMedium.withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: AppColors.primaryMedium.withValues(alpha: 0.4)),
                                          ),
                                          child: Icon(LucideIcons.brain, size: Responsive.iconSize(context, 28), color: AppColors.primaryMedium),
                                        ),
                                        SizedBox(width: 8 * fs),
                                        Icon(LucideIcons.arrowRight, size: Responsive.iconSize(context, 18), color: AppColors.primaryMedium.withValues(alpha: 0.6)),
                                        SizedBox(width: 8 * fs),
                                        // Price tag
                                        Container(
                                          padding: EdgeInsets.all(10 * fs),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryMedium.withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: AppColors.primaryMedium.withValues(alpha: 0.3)),
                                          ),
                                          child: Icon(LucideIcons.indianRupee, size: Responsive.iconSize(context, 28), color: AppColors.primaryMedium),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 14 * fs),
                                    // Labels row
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Scan',
                                            style: AppTypography.labelSmall.copyWith(color: AppColors.primaryLight.withValues(alpha: 0.7), fontSize: 10 * fs),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(width: screenW * 0.08),
                                        Flexible(
                                          child: Text(
                                            'AI Classify',
                                            style: AppTypography.labelSmall.copyWith(color: AppColors.primaryLight.withValues(alpha: 0.7), fontSize: 10 * fs),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(width: screenW * 0.06),
                                        Flexible(
                                          child: Text(
                                            'Market Price',
                                            style: AppTypography.labelSmall.copyWith(color: AppColors.primaryLight.withValues(alpha: 0.7), fontSize: 10 * fs),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 18 * fs),
                                    // Powered by Gemini badge
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16 * fs, vertical: 8 * fs),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryMedium.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: AppColors.primaryMedium.withValues(alpha: 0.4)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(LucideIcons.sparkles, size: Responsive.iconSize(context, 14), color: AppColors.primaryMedium),
                                          SizedBox(width: 6 * fs),
                                          Flexible(
                                            child: Text(
                                              'Powered by Gemini AI',
                                              style: AppTypography.labelSmall.copyWith(
                                                color: AppColors.primaryMedium,
                                                fontSize: 11 * fs,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Confidence tag overlay
                            Positioned(
                              top: 14,
                              left: 14,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12 * fs, vertical: 6 * fs),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryDark.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(LucideIcons.sparkles, size: Responsive.iconSize(context, 14), color: AppColors.primaryMedium),
                                    SizedBox(width: 6 * fs),
                                    Flexible(
                                      child: Text(
                                        'AI Identified • 94% Confidence',
                                        style: AppTypography.labelSmall.copyWith(color: AppColors.surface, fontSize: 11 * fs),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24 * fs),

                    Text('Detected Scrap Materials', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
                    SizedBox(height: 12 * fs),

                    // Detected Items List
                    ...scanState.analyzedItems.map(
                      (item) => Padding(
                        padding: EdgeInsets.only(bottom: 12 * fs),
                        child: CustomCard(
                          padding: EdgeInsets.all(Responsive.padding(context) * 0.8),
                          border: Border.all(color: AppColors.primary, width: 1.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10 * fs),
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryLight,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(LucideIcons.package, color: AppColors.primary, size: Responsive.iconSize(context, 22)),
                                  ),
                                  SizedBox(width: 12 * fs),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.category,
                                          style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          item.subType,
                                          style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8 * fs),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          '₹${item.estimatedTotal.toStringAsFixed(0)}',
                                          style: AppTypography.titleMedium.copyWith(color: AppColors.primary, fontSize: 18 * fs),
                                        ),
                                      ),
                                      Text(
                                        '~${item.weightKg} kg',
                                        style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12 * fs),

                    // Mandatory AI Disclaimer Banner
                    Container(
                      padding: EdgeInsets.all(Responsive.padding(context) * 0.8),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.warning.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(LucideIcons.alertCircle, color: AppColors.warning, size: Responsive.iconSize(context, 20)),
                          SizedBox(width: 12 * fs),
                          Expanded(
                            child: Text(
                              'The AI provides an approximate classification and price estimate. Final classification, weight and price are verified during pickup.',
                              style: AppTypography.bodySmall.copyWith(color: AppColors.textPrimary, height: 1.3, fontSize: 12 * fs),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28 * fs),

                    CustomButton(
                      text: 'Confirm & Schedule Pickup',
                      onPressed: () => context.push('/citizen/schedule-pickup'),
                      icon: LucideIcons.calendarCheck,
                    ),
                    SizedBox(height: 12 * fs),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Retake Photo',
                            onPressed: () => context.pop(),
                            type: ButtonType.outline,
                            icon: LucideIcons.refreshCw,
                          ),
                        ),
                        SizedBox(width: 12 * fs),
                        Expanded(
                          child: CustomButton(
                            text: 'Edit Manually',
                            onPressed: () => context.pop(),
                            type: ButtonType.secondary,
                            icon: LucideIcons.edit3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
