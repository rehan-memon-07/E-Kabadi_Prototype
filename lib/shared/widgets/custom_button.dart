import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

enum ButtonType { primary, secondary, outline, text, danger }

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.width,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    BorderSide border = BorderSide.none;

    switch (widget.type) {
      case ButtonType.primary:
        bg = AppColors.primary;
        fg = AppColors.surface;
        break;
      case ButtonType.secondary:
        bg = AppColors.primaryLight;
        fg = AppColors.primaryDark;
        break;
      case ButtonType.outline:
        bg = Colors.transparent;
        fg = AppColors.textPrimary;
        border = const BorderSide(color: AppColors.border, width: 1.5);
        break;
      case ButtonType.text:
        bg = Colors.transparent;
        fg = AppColors.primary;
        break;
      case ButtonType.danger:
        bg = AppColors.error;
        fg = AppColors.surface;
        break;
    }

    Widget child = widget.isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: fg),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.text,
                  style: AppTypography.labelLarge.copyWith(color: fg),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          );

    return AnimatedScale(
      scale: _isPressed ? 0.97 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: border,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onPressed: widget.isLoading ? null : widget.onPressed,
          onHover: (_) {},
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            behavior: HitTestBehavior.translucent,
            child: child,
          ),
        ),
      ),
    );
  }
}
