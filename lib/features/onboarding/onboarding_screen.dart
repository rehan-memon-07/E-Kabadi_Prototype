import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/custom_button.dart';
import '../../core/utils/responsive_utils.dart';

class OnboardingSlide {
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  OnboardingSlide({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      title: 'Sell your scrap directly from your phone',
      description: 'No more waiting for unorganized collectors. Connect instantly with verified scrap collectors in your locality.',
      icon: LucideIcons.smartphone,
      accentColor: AppColors.primary,
    ),
    OnboardingSlide(
      title: 'AI identifies & estimates your scrap',
      description: 'Snap a picture and let our smart AI categorize materials, estimate weight, and provide transparent price ranges.',
      icon: LucideIcons.scanLine,
      accentColor: AppColors.techBlue,
    ),
    OnboardingSlide(
      title: 'Track pickup. Get paid. Earn rewards.',
      description: 'Real-time collector tracking, instant digital UPI payment at your doorstep, plus Eco Points for saving the planet.',
      icon: LucideIcons.award,
      accentColor: AppColors.rewardOrange,
    ),
  ];

  void _next() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final screenW = Responsive.screenWidth(context);
    final circleSize = screenW * 0.42;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hp, vertical: 16 * fs),
          child: Column(
            children: [
              // Top Bar Skip
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8 * fs),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(LucideIcons.recycle, size: Responsive.iconSize(context, 20), color: AppColors.primary),
                      ),
                      SizedBox(width: 8 * fs),
                      Text(
                        'E-Kabaadi',
                        style: AppTypography.titleMedium.copyWith(color: AppColors.primaryDark, fontSize: 18 * fs),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      'Skip',
                      style: AppTypography.labelLarge.copyWith(color: AppColors.textMuted, fontSize: 14 * fs),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20 * fs),

              // PageView Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentIndex = idx;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: Responsive.scaleHeight(context, 40)),
                          Container(
                            width: circleSize,
                            height: circleSize,
                            decoration: BoxDecoration(
                              color: slide.accentColor.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              slide.icon,
                              size: circleSize * 0.5,
                              color: slide.accentColor,
                            ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
                          ),
                          SizedBox(height: 40 * fs),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: hp * 0.5),
                            child: Text(
                              slide.title,
                              style: AppTypography.displayMedium.copyWith(fontSize: 24 * fs),
                              textAlign: TextAlign.center,
                            ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                          ),
                          SizedBox(height: 14 * fs),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: hp * 0.5),
                            child: Text(
                              slide.description,
                              style: AppTypography.bodyLarge.copyWith(fontSize: 16 * fs),
                              textAlign: TextAlign.center,
                            ).animate().fadeIn(delay: 200.ms),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Dots indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4 * fs),
                    width: _currentIndex == index ? 24 * fs : 8 * fs,
                    height: 8 * fs,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? AppColors.primary
                          : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32 * fs),

              // Bottom Buttons
              CustomButton(
                text: _currentIndex == _slides.length - 1 ? 'Get Started' : 'Continue',
                onPressed: _next,
                icon: LucideIcons.arrowRight,
              ),
              SizedBox(height: 12 * fs),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ', style: AppTypography.bodyMedium.copyWith(fontSize: 14 * fs)),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: Text(
                      'Log in',
                      style: AppTypography.titleSmall.copyWith(color: AppColors.primary, fontSize: 16 * fs),
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
