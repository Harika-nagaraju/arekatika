import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class OtpInput extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final double boxSize;
  final double spacing;
  final TextEditingController? controller;
  final bool error;

  const OtpInput({
    Key? key,
    this.length = 4,
    this.onChanged,
    this.onCompleted,
    this.boxSize = 50,
    this.spacing = 12,
    this.controller,
    this.error = false,
  }) : super(key: key);

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String get _value => _controller.text;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(covariant OtpInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _controller.removeListener(_handleChange);
      _controller.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleChange);
    if (widget.controller == null) _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleChange() {
    final v = _controller.text;
    widget.onChanged?.call(v);
    if (v.length == widget.length) {
      widget.onCompleted?.call(v);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Invisible input
          Opacity(
            opacity: 0.0,
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.length),
              ],
              style: FontUtils.regular(size: 16, color: AppColors.textPrimary),
              decoration: const InputDecoration(border: InputBorder.none),
              autofocus: false,
            ),
          ),

          // Visible boxes
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.length, (i) {
              final isFilled = i < _value.length;
              final isCurrent = _focusNode.hasFocus && i == _value.length;
              final showCursor = isCurrent && _value.length < widget.length;

              return Container(
                width: widget.boxSize,
                height: widget.boxSize,
                margin: EdgeInsets.only(
                  right: i == widget.length - 1 ? 0 : widget.spacing,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.error 
                      ? AppColors.errorRed
                      : isFilled 
                        ? AppColors.brandGreen 
                        : AppColors.stroke,
                    width: widget.error ? 1.5 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: widget.error 
                    ? AppColors.errorLightRed.withOpacity(0.1)
                    : AppColors.white,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isFilled)
                      Text(
                        _value[i],
                        style: FontUtils.bold(
                          size: 18,
                          color: widget.error 
                            ? AppColors.errorRed 
                            : AppColors.textPrimary,
                        ),
                      )
                    else if (showCursor)
                      const _BlinkingCursor(),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor({Key? key}) : super(key: key);

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 2,
        height: 24,
        color: AppColors.brandGreen,
      ),
    );
  }
}