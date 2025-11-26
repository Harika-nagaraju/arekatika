import 'package:flutter/material.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

enum ButtonVariant {
  filled,
  outlined,
}

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  final double borderRadius;
  final double height;
  final double? width;

  final Color? buttonColor;
  final Color? textColor;

  final ButtonVariant variant;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.borderRadius = 6,
    this.height = 45,
    this.width,
    this.buttonColor,
    this.textColor,
    this.variant = ButtonVariant.filled,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _animateTap(bool down) {
    setState(() {
      _scale = down ? 0.97 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onPressed != null && !widget.isLoading;

    Color filledColor = widget.buttonColor ?? AppColors.brandGreen;
    Color disabledColor = AppColors.brandGreenMuted;
    Color textColor =
        widget.textColor ?? AppColors.white;

    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 90),
      child: GestureDetector(
        onTapDown: (_) {
          if (isEnabled) _animateTap(true);
        },
        onTapUp: (_) {
          if (isEnabled) _animateTap(false);
        },
        onTapCancel: () => _animateTap(false),
        child: SizedBox(
          width: widget.width ?? double.infinity,
          height: widget.height,
          child: _buildButton(isEnabled, filledColor, disabledColor, textColor),
        ),
      ),
    );
  }

  Widget _buildButton(
    bool isEnabled,
    Color filledColor,
    Color disabledColor,
    Color textColor,
  ) {
    if (widget.variant == ButtonVariant.outlined) {
      return OutlinedButton(
        onPressed: isEnabled ? widget.onPressed : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isEnabled ? filledColor : disabledColor,
            width: 1.4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
        child: _buildContent(
          textColor: isEnabled ? filledColor : disabledColor,
        ),
      );
    }

    // Filled Button (default)
    return ElevatedButton(
      onPressed: isEnabled ? widget.onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? filledColor : disabledColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      child: _buildContent(textColor: textColor),
    );
  }

  Widget _buildContent({required Color textColor}) {
    if (widget.isLoading) {
      return const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.4,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.prefixIcon != null) ...[
          widget.prefixIcon!,
          const SizedBox(width: 8),
        ],
        Text(
          widget.text.toUpperCase(),
          style: FontUtils.bold(size: 13, color: textColor),
        ),
        if (widget.suffixIcon != null) ...[
          const SizedBox(width: 8),
          widget.suffixIcon!,
        ],
      ],
    );
  }
}
