import 'package:flutter/material.dart';

class NonBlinkInkWell extends StatelessWidget {
  final void onTapAction;
  final Widget child;

  const NonBlinkInkWell({required this.onTapAction, required this.child});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapAction,
      child: child,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}

class BorderRoundedButton extends StatelessWidget {
  final void onTapAction;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Alignment? alignment;
  final Widget child;

  BorderRoundedButton({
    Key? key,
    required this.child,
    this.onTapAction,
    this.width = 50.0,
    this.height = 50.0,
    this.backgroundColor = Colors.grey,
    this.padding,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NonBlinkInkWell(
      onTapAction: () => onTapAction,
      child: Container(
        width: width,
        height: height,
        padding: padding ?? EdgeInsets.all(0.0),
        alignment: alignment,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            width! > height! ? width! * 2 : height! * 2,
          ),
        ),
        child: child,
      ),
    );
  }
}
