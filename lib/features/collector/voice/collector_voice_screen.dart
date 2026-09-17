import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../core/utils/responsive_utils.dart';

class CollectorVoiceScreen extends StatefulWidget {
  const CollectorVoiceScreen({super.key});

  @override
  State<CollectorVoiceScreen> createState() => _CollectorVoiceScreenState();
}

class _CollectorVoiceScreenState extends State<CollectorVoiceScreen> {
  bool _isListening = false;
  String _recognizedText = 'Tap the microphone and speak...';

  void _startListening(String command) async {
    setState(() {
      _isListening = true;
      _recognizedText = 'Listening... ("$command")';
    });
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isListening = false;
        _recognizedText = 'Recognized: "$command"';
      });
      // Execute command navigation demo
      if (command.contains('nearby') || command.contains('pickups')) {
        context.go('/collector/dashboard');
      } else if (command.contains('Navigate')) {
        context.go('/collector/navigation');
      } else if (command.contains('complete')) {
        context.go('/collector/verify');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final screenW = Responsive.screenWidth(context);
    final outerCircle = screenW * 0.55;
    final innerCircle = screenW * 0.38;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Collector Voice Assistant', showBack: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(hp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Voice Visualizer Circle
              GestureDetector(
                onTap: () => _startListening('Show nearby pickups'),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_isListening)
                      Container(
                        width: outerCircle,
                        height: outerCircle,
                        decoration: const BoxDecoration(
                          color: AppColors.techBlueLight,
                          shape: BoxShape.circle,
                        ),
                      ).animate(onPlay: (c) => c.repeat()).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.3, 1.3), duration: 1000.ms),
                    Container(
                      width: innerCircle,
                      height: innerCircle,
                      decoration: const BoxDecoration(
                        color: AppColors.techBlue,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Color(0x330284C7), blurRadius: 20, spreadRadius: 4)],
                      ),
                      child: Icon(
                        _isListening ? LucideIcons.micOff : LucideIcons.mic,
                        size: innerCircle * 0.45,
                        color: AppColors.surface,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36 * fs),

              Text(
                'Say what you want to do',
                style: AppTypography.displayMedium.copyWith(fontSize: 24 * fs),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12 * fs),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20 * fs, vertical: 12 * fs),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _recognizedText,
                  style: AppTypography.titleSmall.copyWith(color: AppColors.techBlue, fontSize: 16 * fs),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40 * fs),

              // Voice Command Quick Action Shortcuts
              Text('Quick Voice Commands', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 16 * fs),

              Wrap(
                spacing: 10 * fs,
                runSpacing: 10 * fs,
                alignment: WrapAlignment.center,
                children: [
                  _buildCommandChip('Show nearby pickups', fs),
                  _buildCommandChip('Accept this pickup', fs),
                  _buildCommandChip('Navigate to customer', fs),
                  _buildCommandChip('Mark pickup complete', fs),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommandChip(String command, double fs) {
    return ActionChip(
      avatar: Icon(LucideIcons.volume2, size: Responsive.iconSize(context, 16), color: AppColors.techBlue),
      label: Text(
        command,
        style: AppTypography.labelLarge.copyWith(color: AppColors.techBlue, fontSize: 14 * fs),
      ),
      backgroundColor: AppColors.techBlueLight,
      onPressed: () => _startListening(command),
    );
  }
}
