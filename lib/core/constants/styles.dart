import 'package:flutter/material.dart';
import './sizes.dart';
import './colors.dart';

abstract final class AppStyles {
  static const text = TextStyle(
    fontSize: 14,
  );

  static const label = TextStyle(
    fontSize: 16,
    height: 1
  );

  static const button = ButtonStyle(
    padding: WidgetStatePropertyAll(AppPaddings.medium),
    iconSize: WidgetStatePropertyAll(18),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: AppBorderRadius.tiny)),
    foregroundColor: WidgetStateMapper({
      WidgetState.disabled: AppBaseColor.s600,
      WidgetState.hovered: AppBaseColor.s50,
      WidgetState.focused: AppBaseColor.s50,
      WidgetState.pressed: AppBaseColor.s50,
      WidgetState.any: Colors.transparent,
    }),
    backgroundBuilder: _buttonBackgroundBuilder
  );
}

abstract final class AppBorders {
  static const underline = BorderSide(
    width: 2,
    color: Colors.green,
  );
  static const underlineRed = BorderSide(
    width: 2,
    color: Colors.red
  );
  static const underlineGrey = BorderSide(
    width: 2,
    color: AppBaseColor.s500
  );
  static const underlineWhite = BorderSide(
    width: 2,
    color: AppBaseColor.s500
  );
}

mixin ColorStylableWidget on Widget {
  Color? get backgroundColor;
  Color? get foregroundColor;
}

// mixin ButtonStylable on Widget implements ColorStylableWidget {
//   @override
//   Color? get backgroundColor => null;
//   @override
//   Color? get foregroundColor => null;

//   TextStyle get defaultTextStyle => const TextStyle();
//   bool get hollow => false;
//   Border? get border => null;
// }

class ButtonStylable extends StatelessWidget {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle defaultTextStyle;
  final bool hollow;
  final Border? border;
  final Widget child;

  const ButtonStylable({
    super.key,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.defaultTextStyle = const TextStyle(),
    this.hollow = false,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

Widget _buttonBackgroundBuilder(BuildContext context, Set<WidgetState> states, Widget? child) {
  final buttonStylable = context.findAncestorWidgetOfExactType<ButtonStylable>();
  final hollow = buttonStylable?.hollow ?? false;
  final colorScheme = ColorScheme.of(context);
  return AnimatedContainer(
    duration: kThemeAnimationDuration,
    decoration: BoxDecoration(
      color: hollow
        ? null
        : buttonStylable?.backgroundColor ?? colorScheme.primary,
      border: hollow
        ? buttonStylable?.border ?? Border.fromBorderSide(BorderSide(
          width: 2,
          color: buttonStylable?.backgroundColor ?? Colors.transparent
        ))
        : null,
      borderRadius: AppBorderRadius.tiny
    ),
    child: DefaultTextStyle(
      style: buttonStylable?.defaultTextStyle.copyWith(
        color: buttonStylable.foregroundColor,
      ) ?? const TextStyle(
        color: AppBaseColor.s50,
      ),
      child: child ?? const SizedBox.shrink()
    ),
  );
}