import 'package:flutter/material.dart' show BorderRadius, EdgeInsets, Radius;

abstract final class AppBorderRadius {
  static const zero = BorderRadius.zero;

  static const tiny = BorderRadius.all(Radius.circular(4.0));
  static const small = BorderRadius.all(Radius.circular(8.0));
  static const medium = BorderRadius.all(Radius.circular(12.0));
  static const big = BorderRadius.all(Radius.circular(16.0));
  static const giant = BorderRadius.all(Radius.circular(24.0));
}

abstract final class AppPaddings {
  static const zero = EdgeInsets.zero;

  static const tiny = EdgeInsets.all(4.0);
  static const small = EdgeInsets.all(8.0);
  static const medium = EdgeInsets.all(12.0);
  static const big = EdgeInsets.all(16.0);
  static const giant = EdgeInsets.all(24.0);
}