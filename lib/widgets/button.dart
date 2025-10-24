import 'package:flutter/material.dart';
import '../core/constants/styles.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool enabled;
  final void Function() onPressed;

  const AppButton({
    required this.onPressed,
    required this.child,
    this.color,
    this.enabled = true,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ButtonStylable(
      backgroundColor: color,
      defaultTextStyle: TextStyle(
        fontSize: 16,
        // fontWeight: FontW
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: AppStyles.button,
        child: child
      ),
    );
  }
}