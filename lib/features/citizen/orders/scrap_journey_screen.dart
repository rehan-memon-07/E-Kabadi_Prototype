import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../providers/rewards_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class ScrapJourneyScreen extends ConsumerWidget {
  const ScrapJourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journeysAsync = ref.watch(recyclingJourneysProvider);
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Scrap Journey & Traceability'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(hp),
          child: journeysAsync.when(
            data: (journeys) {
              if (journeys.isEmpty) return const Center(child: Text('No journey records'));
              final jrn = journeys.first;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Certificate Banner
                  Container(
                    padding: EdgeInsets.all(p),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(LucideIcons.award, color: AppColors.surface, size: Responsive.iconSize(context, 28)),
                            SizedBox(width: 10 * fs),
                            Expanded(
                              child: Text(
                                'Verified Recycling Certificate',
                                style: AppTypography.titleMedium.copyWith(color: AppColors.surface, fontSize: 18 * fs),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12 * fs),
                        Text(
                          'Batch ID: ${jrn.certificateId}',
                          style: AppTypography.labelSmall.copyWith(color: AppColors.primaryLight, fontSize: 11 * fs),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4 * fs),
                        Text(
                          '${jrn.materialCategory} • ${jrn.weightKg} kg Recycled',
                          style: AppTypography.titleLarge.copyWith(color: AppColors.surface, fontSize: 20 * fs),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28 * fs),

                  Text(
                    'End-to-End Material Traceability Timeline',
                    style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs),
                  ),
                  SizedBox(height: 16 * fs),

                  // Vertical Timeline Steps
                  ...List.generate(jrn.steps.length, (index) {
                    final step = jrn.steps[index];
                    final isLast = index == jrn.steps.length - 1;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10 * fs),
                              decoration: BoxDecoration(
                                color: step.isCompleted ? AppColors.primary : AppColors.surfaceVariant,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                step.isCompleted ? LucideIcons.check : LucideIcons.circle,
                                size: Responsive.iconSize(context, 16),
                                color: step.isCompleted ? AppColors.surface : AppColors.textMuted,
                              ),
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 50 * fs,
                                color: step.isCompleted ? AppColors.primary : AppColors.border,
                              ),
                          ],
                        ),
                        SizedBox(width: 16 * fs),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20 * fs),
                            child: CustomCard(
                              padding: EdgeInsets.all(p * 0.8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          step.title,
                                          style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(width: 8 * fs),
                                      Text(
                                        step.timestamp,
                                        style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4 * fs),
                                  Text(
                                    step.description,
                                    style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6 * fs),
                                  Row(
                                    children: [
                                      Icon(LucideIcons.mapPin, size: Responsive.iconSize(context, 14), color: AppColors.primary),
                                      SizedBox(width: 4 * fs),
                                      Expanded(
                                        child: Text(
                                          step.location,
                                          style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontSize: 11 * fs),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Text('Error: $e'),
          ),
        ),
      ),
    );
  }
}
