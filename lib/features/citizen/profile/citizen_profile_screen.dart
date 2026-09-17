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

class CitizenProfileScreen extends ConsumerStatefulWidget {
  const CitizenProfileScreen({super.key});

  @override
  ConsumerState<CitizenProfileScreen> createState() => _CitizenProfileScreenState();
}

class _CitizenProfileScreenState extends ConsumerState<CitizenProfileScreen> {
  String _selectedLanguage = 'English';

  void _switchRole() async {
    await ref.read(authProvider.notifier).setRole(UserRole.collector);
    if (mounted) {
      context.go('/collector/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Citizen Profile', showBack: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Header Card
              CustomCard(
                padding: EdgeInsets.all(p),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32 * fs,
                      backgroundColor: AppColors.primaryLight,
                      child: Text(
                        user?.name.substring(0, 1) ?? 'A',
                        style: AppTypography.displayMedium.copyWith(color: AppColors.primaryDark, fontSize: 22 * fs),
                      ),
                    ),
                    SizedBox(width: 16 * fs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'Aarav Sharma',
                            style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2 * fs),
                          Text(
                            user?.phone ?? '+91 98765 12345',
                            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                          ),
                          SizedBox(height: 2 * fs),
                          Text(
                            'Role: Citizen Household',
                            style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontSize: 11 * fs),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20 * fs),

              // Switch Role Action Card
              CustomCard(
                padding: EdgeInsets.all(p * 0.8),
                color: AppColors.techBlueLight,
                border: Border.all(color: AppColors.techBlue, width: 1.5),
                onTap: _switchRole,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10 * fs),
                      decoration: const BoxDecoration(
                        color: AppColors.techBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(LucideIcons.truck, color: AppColors.surface, size: Responsive.iconSize(context, 20)),
                    ),
                    SizedBox(width: 14 * fs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Switch to Scrap Collector Mode',
                            style: AppTypography.titleSmall.copyWith(color: AppColors.techBlue, fontSize: 16 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Collect scrap, earn Eco Coins & route pickups',
                            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(LucideIcons.arrowRight, color: AppColors.techBlue, size: Responsive.iconSize(context, 20)),
                  ],
                ),
              ),
              SizedBox(height: 28 * fs),

              Text('Account Settings', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 12 * fs),

              _buildOptionTile(
                context,
                fs: fs,
                p: p,
                icon: LucideIcons.mapPin,
                title: 'Saved Addresses',
                subtitle: 'Flat 402, Green Valley, Noida',
                onTap: () {},
              ),
              _buildOptionTile(
                context,
                fs: fs,
                p: p,
                icon: LucideIcons.wallet,
                title: 'Payment Methods & UPI',
                subtitle: 'GPay • aarav@upi',
                onTap: () {},
              ),
              _buildOptionTile(
                context,
                fs: fs,
                p: p,
                icon: LucideIcons.globe,
                title: 'App Language',
                subtitle: _selectedLanguage,
                onTap: _showLanguageDialog,
              ),
              _buildOptionTile(
                context,
                fs: fs,
                p: p,
                icon: LucideIcons.helpCircle,
                title: 'Help & Customer Support',
                subtitle: '24/7 Helpline & FAQs',
                onTap: () {},
              ),
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

  Widget _buildOptionTile(
    BuildContext context, {
    required double fs,
    required double p,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10 * fs),
      child: CustomCard(
        padding: EdgeInsets.all(p * 0.8),
        onTap: onTap,
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
            Icon(LucideIcons.chevronRight, size: Responsive.iconSize(context, 18), color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select App Language', style: AppTypography.titleMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              trailing: _selectedLanguage == 'English' ? const Icon(LucideIcons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() => _selectedLanguage = 'English');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('हिन्दी (Hindi)'),
              trailing: _selectedLanguage == 'Hindi' ? const Icon(LucideIcons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() => _selectedLanguage = 'Hindi');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
