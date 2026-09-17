import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/user_model.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class CollectorProfileScreen extends ConsumerWidget {
  const CollectorProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Collector Profile & Verification', showBack: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Collector Card Header
              CustomCard(
                padding: EdgeInsets.all(p),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 34 * fs,
                      backgroundColor: AppColors.techBlue,
                      child: Text('RK', style: AppTypography.displayMedium.copyWith(color: AppColors.surface, fontSize: 22 * fs)),
                    ),
                    SizedBox(width: 16 * fs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Ramesh Kumar',
                                  style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 6 * fs),
                              Icon(LucideIcons.badgeCheck, size: Responsive.iconSize(context, 20), color: AppColors.techBlue),
                            ],
                          ),
                          SizedBox(height: 2 * fs),
                          Text(
                            'ID: COL-EK-892 • Sector 62 Zone',
                            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4 * fs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8 * fs, vertical: 2 * fs),
                            decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(100)),
                            child: Text('KYC VERIFIED', style: AppTypography.labelSmall.copyWith(color: AppColors.success, fontSize: 10 * fs)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20 * fs),

              // Switch to Citizen Role Option
              CustomCard(
                padding: EdgeInsets.all(p * 0.8),
                color: AppColors.primaryLight,
                border: Border.all(color: AppColors.primary, width: 1.5),
                onTap: () async {
                  await ref.read(authProvider.notifier).setRole(UserRole.citizen);
                  if (context.mounted) {
                    context.go('/citizen/home');
                  }
                },
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10 * fs),
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: Icon(LucideIcons.home, color: AppColors.surface, size: Responsive.iconSize(context, 20)),
                    ),
                    SizedBox(width: 14 * fs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Switch to Citizen Household Mode',
                            style: AppTypography.titleSmall.copyWith(color: AppColors.primaryDark, fontSize: 16 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Sell household scrap & track pickups',
                            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(LucideIcons.arrowRight, color: AppColors.primary, size: Responsive.iconSize(context, 20)),
                  ],
                ),
              ),
              SizedBox(height: 28 * fs),

              Text('Verification & Vehicle Details', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 12 * fs),

              _buildDetailTile(context, fs, p, LucideIcons.shieldCheck, 'Aadhaar & KYC Document', 'Verified • Unique ID 8912-****'),
              _buildDetailTile(context, fs, p, LucideIcons.truck, 'Registered Vehicle', 'Mahindra Pickup • UP16 ET 4912'),
              _buildDetailTile(context, fs, p, LucideIcons.building, 'ULB & Recycler License', 'Authorized Partner #REC-2026'),
              _buildDetailTile(context, fs, p, LucideIcons.star, 'Customer Service Rating', '4.8 / 5.0 (480 Reviews)'),

              SizedBox(height: 24 * fs),
              CustomButton(
                text: 'Log Out',
                onPressed: () async {
                  await ref.read(authProvider.notifier).logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
                type: ButtonType.danger,
                icon: LucideIcons.logOut,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailTile(BuildContext context, double fs, double p, IconData icon, String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10 * fs),
      child: CustomCard(
        padding: EdgeInsets.all(p * 0.8),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textPrimary, size: Responsive.iconSize(context, 22)),
            SizedBox(width: 14 * fs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
