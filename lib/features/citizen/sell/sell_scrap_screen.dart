import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../providers/scrap_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class SellScrapScreen extends ConsumerWidget {
  const SellScrapScreen({super.key});

  void _startAiScan(BuildContext context, WidgetRef ref) async {
    // Start scan and navigate to AI analysis screen
    await ref.read(scrapScanProvider.notifier).analyzeImage('assets/images/img 1.png');
    if (context.mounted) {
      context.push('/citizen/ai-analysis');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryPricesProvider);
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);
    final screenW = Responsive.screenWidth(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Sell Your Scrap', showBack: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload a Photo & Let AI Identify',
                style: AppTypography.titleLarge.copyWith(fontSize: 22 * fs),
              ),
              SizedBox(height: 6 * fs),
              Text(
                'Our computer vision AI will scan materials, estimate weight, and calculate approximate market value.',
                style: AppTypography.bodyMedium.copyWith(fontSize: 14 * fs),
              ),
              SizedBox(height: 24 * fs),

              // Camera Upload Hero Box
              CustomCard(
                padding: EdgeInsets.all(p * 1.2),
                color: AppColors.primaryLight.withValues(alpha: 0.5),
                border: Border.all(color: AppColors.primary, width: 2),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20 * fs),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(LucideIcons.camera, size: Responsive.iconSize(context, 40), color: AppColors.surface),
                    ),
                    SizedBox(height: 16 * fs),
                    Text(
                      'Scan Scrap with AI Camera',
                      style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 6 * fs),
                    Text(
                      'Supports Plastic, Paper, Metals, E-Waste & Appliances',
                      style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20 * fs),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Take Photo',
                            onPressed: () => _startAiScan(context, ref),
                            icon: LucideIcons.camera,
                          ),
                        ),
                        SizedBox(width: 12 * fs),
                        Expanded(
                          child: CustomButton(
                            text: 'From Gallery',
                            onPressed: () => _startAiScan(context, ref),
                            type: ButtonType.secondary,
                            icon: LucideIcons.image,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28 * fs),

              // Category Rates Grid
              Text('Live Scrap Rates', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 12 * fs),

              categoriesAsync.when(
                data: (categories) => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12 * fs,
                    mainAxisSpacing: 12 * fs,
                    childAspectRatio: screenW < 360 ? 1.15 : 1.35,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return CustomCard(
                      padding: EdgeInsets.all(14 * fs),
                      onTap: () {
                        ref.read(scrapScanProvider.notifier).selectCategory(cat.category);
                        _startAiScan(context, ref);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8 * fs),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(LucideIcons.package, size: Responsive.iconSize(context, 20), color: AppColors.primary),
                              ),
                              Icon(LucideIcons.chevronRight, size: Responsive.iconSize(context, 18), color: AppColors.textMuted),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            cat.category,
                            style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2 * fs),
                          Text(
                            cat.priceRange,
                            style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontSize: 11 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Error loading categories: $err'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
