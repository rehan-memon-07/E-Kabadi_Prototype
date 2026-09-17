import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../core/utils/responsive_utils.dart';

class CollectorMatchingScreen extends StatefulWidget {
  const CollectorMatchingScreen({super.key});

  @override
  State<CollectorMatchingScreen> createState() => _CollectorMatchingScreenState();
}

class _CollectorMatchingScreenState extends State<CollectorMatchingScreen> {
  bool _isFound = false;

  @override
  void initState() {
    super.initState();
    _startMatchingAnimation();
  }

  void _startMatchingAnimation() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _isFound = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final screenW = Responsive.screenWidth(context);
    final radarSize = screenW * 0.5;
    final innerCircle = radarSize * 0.64;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(hp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_isFound) ...[
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: radarSize,
                      height: radarSize,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ).animate(onPlay: (c) => c.repeat()).scale(begin: const Offset(0.8, 0.8), end: const Offset(1.3, 1.3), duration: 1500.ms),
                    Container(
                      width: innerCircle,
                      height: innerCircle,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(LucideIcons.radar, size: innerCircle * 0.5, color: AppColors.surface),
                    ),
                  ],
                ),
                SizedBox(height: 40 * fs),
                Text(
                  'Finding Nearby Collector...',
                  style: AppTypography.displayMedium.copyWith(fontSize: 22 * fs),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10 * fs),
                Text(
                  'Connecting with verified scrap collectors within 3 km of your area',
                  style: AppTypography.bodyLarge.copyWith(fontSize: 16 * fs),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
              ] else ...[
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(20 * fs),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(LucideIcons.checkCircle2, size: Responsive.iconSize(context, 64), color: AppColors.primary),
                ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
                SizedBox(height: 20 * fs),
                Text(
                  'Collector Found!',
                  style: AppTypography.displayMedium.copyWith(fontSize: 26 * fs),
                ),
                SizedBox(height: 6 * fs),
                Text(
                  'Ramesh Kumar accepted your pickup request',
                  style: AppTypography.bodyLarge.copyWith(fontSize: 16 * fs),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32 * fs),

                // Collector Card
                CustomCard(
                  padding: EdgeInsets.all(Responsive.padding(context)),
                  border: Border.all(color: AppColors.primary, width: 2),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 32 * fs,
                            backgroundColor: AppColors.primaryLight,
                            child: Text(
                              'RK',
                              style: AppTypography.titleLarge.copyWith(color: AppColors.primaryDark, fontSize: 22 * fs),
                            ),
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
                                    Icon(LucideIcons.badgeCheck, size: Responsive.iconSize(context, 18), color: AppColors.techBlue),
                                  ],
                                ),
                                SizedBox(height: 4 * fs),
                                Row(
                                  children: [
                                    Icon(LucideIcons.star, size: Responsive.iconSize(context, 14), color: AppColors.warning),
                                    SizedBox(width: 4 * fs),
                                    Flexible(
                                      child: Text(
                                        '4.8 Rating • 480 Pickups',
                                        style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4 * fs),
                                Text(
                                  'Vehicle: Mahindra Pickup (UP16 ET 4912)',
                                  style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted, fontSize: 12 * fs),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16 * fs),
                      const Divider(color: AppColors.border),
                      SizedBox(height: 12 * fs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(LucideIcons.mapPin, size: Responsive.iconSize(context, 16), color: AppColors.primary),
                                SizedBox(width: 6 * fs),
                                Flexible(
                                  child: Text(
                                    '1.2 km away',
                                    style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8 * fs),
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(LucideIcons.clock, size: Responsive.iconSize(context, 16), color: AppColors.techBlue),
                                SizedBox(width: 6 * fs),
                                Flexible(
                                  child: Text(
                                    'ETA ~6 mins',
                                    style: AppTypography.titleSmall.copyWith(color: AppColors.techBlue, fontSize: 16 * fs),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn().slideY(begin: 0.2, end: 0),

                const Spacer(),
                CustomButton(
                  text: 'Track Collector Live',
                  onPressed: () => context.go('/citizen/live-tracking'),
                  icon: LucideIcons.navigation,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
