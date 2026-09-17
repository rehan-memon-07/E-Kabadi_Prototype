import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../providers/collector_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class CollectorDashboardScreen extends ConsumerWidget {
  const CollectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectorState = ref.watch(collectorProvider);
    final isAvailable = collectorState.isAvailable;
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hp, vertical: 16 * fs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header & Availability Switch
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Ramesh Kumar',
                                style: AppTypography.titleLarge.copyWith(fontSize: 22 * fs),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 6 * fs),
                            Icon(LucideIcons.badgeCheck, size: Responsive.iconSize(context, 20), color: AppColors.techBlue),
                          ],
                        ),
                        Text(
                          'Sector 62 & 63 Zone, Noida',
                          style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8 * fs),
                  IconButton(
                    onPressed: () => context.go('/collector/voice'),
                    icon: Container(
                      padding: EdgeInsets.all(10 * fs),
                      decoration: const BoxDecoration(color: AppColors.techBlueLight, shape: BoxShape.circle),
                      child: Icon(LucideIcons.mic, color: AppColors.techBlue, size: Responsive.iconSize(context, 22)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20 * fs),

              // Availability Toggle Switch Box
              CustomCard(
                padding: EdgeInsets.symmetric(horizontal: p, vertical: 14 * fs),
                color: isAvailable ? AppColors.primaryLight : AppColors.surfaceVariant,
                border: Border.all(color: isAvailable ? AppColors.primary : AppColors.border, width: 1.5),
                child: Row(
                  children: [
                    Container(
                      width: 12 * fs,
                      height: 12 * fs,
                      decoration: BoxDecoration(
                        color: isAvailable ? AppColors.success : AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10 * fs),
                    Expanded(
                      child: Text(
                        isAvailable ? 'ONLINE • AVAILABLE FOR PICKUPS' : 'OFFLINE • DUTY PAUSED',
                        style: AppTypography.labelSmall.copyWith(
                          color: isAvailable ? AppColors.primaryDark : AppColors.textMuted,
                          fontWeight: FontWeight.bold,
                          fontSize: 11 * fs,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Switch(
                      value: isAvailable,
                      onChanged: (val) {
                        ref.read(collectorProvider.notifier).toggleAvailability(val);
                      },
                      activeThumbColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24 * fs),

              // Operational Metrics Grid
              Row(
                children: [
                  Expanded(
                    child: CustomCard(
                      padding: EdgeInsets.all(p * 0.8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(LucideIcons.wallet, color: AppColors.primary, size: Responsive.iconSize(context, 24)),
                          SizedBox(height: 10 * fs),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '₹${collectorState.todayEarnings.toStringAsFixed(0)}',
                              style: AppTypography.titleLarge.copyWith(fontSize: 20 * fs),
                            ),
                          ),
                          Text(
                            'Today Earnings',
                            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12 * fs),
                  Expanded(
                    child: CustomCard(
                      padding: EdgeInsets.all(p * 0.8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(LucideIcons.package, color: AppColors.techBlue, size: Responsive.iconSize(context, 24)),
                          SizedBox(height: 10 * fs),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${collectorState.todayPickupsCount}',
                              style: AppTypography.titleLarge.copyWith(fontSize: 20 * fs),
                            ),
                          ),
                          Text(
                            'Completed Pickups',
                            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12 * fs),
                  Expanded(
                    child: CustomCard(
                      padding: EdgeInsets.all(p * 0.8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(LucideIcons.scale, color: AppColors.warning, size: Responsive.iconSize(context, 24)),
                          SizedBox(height: 10 * fs),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${collectorState.todayWeightKg} kg',
                              style: AppTypography.titleLarge.copyWith(fontSize: 20 * fs),
                            ),
                          ),
                          Text(
                            'Scrap Collected',
                            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28 * fs),

              // Nearby Requests Section Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Nearby Pickup Requests 📍',
                      style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8 * fs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10 * fs, vertical: 4 * fs),
                    decoration: BoxDecoration(color: AppColors.techBlueLight, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      '3 Live Requests',
                      style: AppTypography.labelSmall.copyWith(color: AppColors.techBlue, fontSize: 11 * fs),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14 * fs),

              // Request Card 1
              _buildRequestCard(
                context: context,
                ref: ref,
                fs: fs,
                p: p,
                distance: '1.2 km away • Sector 62',
                estimate: 'Est. ₹118',
                household: 'Household: Aarav Sharma',
                address: 'Address: Flat 402, Green Valley Apts, Sector 62',
                material: 'Plastic PET & Cardboard (~4.6 kg)',
                materialIcon: LucideIcons.package,
                isPrimary: true,
                onAccept: () {
                  ref.read(collectorProvider.notifier).acceptRequest(collectorState.nearbyRequests.first);
                  context.go('/collector/navigation');
                },
                onViewDetails: () => context.go('/collector/navigation'),
              ),
              SizedBox(height: 14 * fs),

              // Request Card 2
              _buildRequestCard(
                context: context,
                ref: ref,
                fs: fs,
                p: p,
                distance: '2.4 km away • Sector 63',
                estimate: 'Est. ₹850',
                household: 'Household: Priya Verma',
                address: 'Address: House 84, Block B, Sector 63',
                material: 'E-Waste: Old Laptops & Cables (~3.0 kg)',
                materialIcon: LucideIcons.cpu,
                isPrimary: false,
                onAccept: () => context.go('/collector/navigation'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard({
    required BuildContext context,
    required WidgetRef ref,
    required double fs,
    required double p,
    required String distance,
    required String estimate,
    required String household,
    required String address,
    required String material,
    required IconData materialIcon,
    required bool isPrimary,
    required VoidCallback onAccept,
    VoidCallback? onViewDetails,
  }) {
    return CustomCard(
      padding: EdgeInsets.all(p * 0.9),
      border: isPrimary ? Border.all(color: AppColors.techBlue, width: 1.5) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.mapPin, size: Responsive.iconSize(context, 16), color: isPrimary ? AppColors.primary : AppColors.textMuted),
              SizedBox(width: 6 * fs),
              Expanded(
                child: Text(
                  distance,
                  style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8 * fs),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    estimate,
                    style: AppTypography.titleMedium.copyWith(color: AppColors.primary, fontSize: 18 * fs),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10 * fs),
          Text(
            household,
            style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary, fontSize: 14 * fs),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            address,
            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10 * fs),
          Container(
            padding: EdgeInsets.all(10 * fs),
            decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(materialIcon, size: Responsive.iconSize(context, 16), color: AppColors.textMuted),
                SizedBox(width: 8 * fs),
                Expanded(
                  child: Text(
                    material,
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textPrimary, fontSize: 12 * fs),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16 * fs),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Accept Request',
                  onPressed: onAccept,
                  type: ButtonType.primary,
                  icon: LucideIcons.check,
                ),
              ),
              if (onViewDetails != null) ...[
                SizedBox(width: 12 * fs),
                Expanded(
                  child: CustomButton(
                    text: 'View Details',
                    onPressed: onViewDetails,
                    type: ButtonType.secondary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
