import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arekatika/utils/appcolors.dart';
import 'package:arekatika/utils/fontutils.dart';

class OtpInput extends StatefulWidget {
  final int length; // number of boxes (e.g., 4 / 6)
  final ValueChanged<String>? onChanged; // fires on every change
  final ValueChanged<String>? onCompleted; // fires when filled
  final double boxSize; // width/height of each box
  final double spacing; // space between boxes
  final TextEditingController? controller;
  final bool error; // highlights error state

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
    // Hidden text field captures all input; boxes show the characters.
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
              // Keep font to ensure consistent metrics even when invisible
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
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.error
                        ? AppColors.error
                        : (isCurrent ? AppColors.brandGreen : AppColors.stroke),
                    width: widget.error ? 1.5 : (isCurrent ? 1.5 : 1),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 120),
                  child: isFilled
                      ? Text(
                          _value[i],
                          key: ValueKey('v$i'),
                          style: FontUtils.bold(
                            size: 18,
                            color: AppColors.textPrimary,
                          ),
                        )
                      : (showCursor
                            ? _BlinkingCursor(
                                key: ValueKey('c$i'),
                                height: 18,
                                color: AppColors.brandGreen,
                              )
                            : Text(
                                '',
                                key: ValueKey('e$i'),
                                style: FontUtils.bold(
                                  size: 18,
                                  color: AppColors.textPrimary,
                                ),
                              )),
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
  final double height;
  final Color color;
  const _BlinkingCursor({Key? key, required this.height, required this.color})
    : super(key: key);

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ac.drive(Tween(begin: 1.0, end: 0.2)),
      child: Container(width: 2, height: widget.height, color: widget.color),
    );
  }
}
