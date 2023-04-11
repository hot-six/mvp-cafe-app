import 'package:flutter/material.dart';

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
