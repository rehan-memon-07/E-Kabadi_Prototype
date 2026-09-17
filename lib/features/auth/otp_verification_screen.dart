import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/custom_button.dart';
import '../../providers/auth_provider.dart';
import '../../core/utils/responsive_utils.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController(text: '4'));
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Pre-fill demo OTP code 4829
    _controllers[0].text = '4';
    _controllers[1].text = '8';
    _controllers[2].text = '2';
    _controllers[3].text = '9';
  }

  void _onVerify() async {
    final otp = _controllers.map((c) => c.text).join();
    await ref.read(authProvider.notifier).verifyOtp(widget.phoneNumber, otp);
    if (mounted) {
      context.go('/location-permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final screenW = Responsive.screenWidth(context);
    final digitSize = screenW < 360 ? 52.0 : 60.0;
    final digitHeight = screenW < 360 ? 56.0 : 64.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hp, vertical: 16 * fs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify Phone Number',
                style: AppTypography.displayMedium.copyWith(fontSize: 26 * fs),
              ),
              SizedBox(height: 8 * fs),
              Text(
                'Enter the 4-digit code sent to +91 ${widget.phoneNumber}',
                style: AppTypography.bodyLarge.copyWith(fontSize: 16 * fs),
              ),
              SizedBox(height: 36 * fs),

              // OTP Digits Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: digitSize * fs,
                    height: digitHeight * fs,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: AppTypography.displayMedium.copyWith(color: AppColors.primary, fontSize: 24 * fs),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.surfaceVariant,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: AppColors.primary, width: 2),
                        ),
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty && index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32 * fs),

              CustomButton(
                text: 'Verify & Continue',
                onPressed: _onVerify,
                isLoading: authState.isLoading,
              ),
              SizedBox(height: 20 * fs),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Resend Code in 00:24',
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted, fontSize: 14 * fs),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
