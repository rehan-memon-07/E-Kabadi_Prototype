import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../providers/pickup_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class PickupHistoryScreen extends ConsumerWidget {
  const PickupHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickupState = ref.watch(pickupProvider);
    final pickups = pickupState.allPickups;
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Pickup Orders & Traceability', showBack: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Scrap Orders', style: AppTypography.titleLarge.copyWith(fontSize: 22 * fs)),
              SizedBox(height: 6 * fs),
              Text(
                'Track doorstep pickup status, receipts & recycling certificates.',
                style: AppTypography.bodyMedium.copyWith(fontSize: 14 * fs),
              ),
              SizedBox(height: 20 * fs),

              if (pickups.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40 * fs),
                    child: Text('No pickup history found.', style: AppTypography.bodyMedium.copyWith(fontSize: 14 * fs)),
                  ),
                )
              else
                Column(
                  children: pickups.map((pickup) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 14 * fs),
                      child: CustomCard(
                        padding: EdgeInsets.all(p * 0.8),
                        onTap: () => context.push('/citizen/scrap-journey'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(LucideIcons.calendar, size: Responsive.iconSize(context, 16), color: AppColors.textMuted),
                                SizedBox(width: 6 * fs),
                                Expanded(
                                  child: Text(
                                    pickup.scheduledDate,
                                    style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8 * fs),
                                StatusBadge(status: pickup.status),
                              ],
                            ),
                            const Divider(height: 20),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12 * fs),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryLight,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(LucideIcons.packageCheck, color: AppColors.primary, size: Responsive.iconSize(context, 22)),
                                ),
                                SizedBox(width: 14 * fs),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pickup.items.map((i) => i.category).toSet().join(', '),
                                        style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 2 * fs),
                                      Text(
                                        'Collector: ${pickup.collectorName}',
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
                                        '₹${pickup.totalEstimatedPrice.toStringAsFixed(0)}',
                                        style: AppTypography.titleSmall.copyWith(color: AppColors.primary, fontSize: 16 * fs),
                                      ),
                                    ),
                                    SizedBox(height: 4 * fs),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Traceability',
                                          style: AppTypography.labelSmall.copyWith(color: AppColors.techBlue, fontSize: 11 * fs),
                                        ),
                                        Icon(LucideIcons.chevronRight, size: Responsive.iconSize(context, 14), color: AppColors.techBlue),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
