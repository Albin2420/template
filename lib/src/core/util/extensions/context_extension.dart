import 'package:flutter/material.dart';

enum ScreenSize { sm, md, lg, xl }

extension ContextUtils on BuildContext {
  /// size info
  ///
  ///
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;

  /// responsive
  ///
  ///
  T responsive<T>(T defaultValue, {T? sm, T? md, T? lg, T? xl}) {
    final w = MediaQuery.of(this).size.width;
    return w >= 1280
        ? (xl ?? lg ?? md ?? sm ?? defaultValue)
        : w >= 1024
            ? (lg ?? md ?? sm ?? defaultValue)
            : w >= 768
                ? (md ?? sm ?? defaultValue)
                : w >= 640
                    ? (sm ?? defaultValue)
                    : defaultValue;
  }

  /// platform
  ///
  ///
  TargetPlatform currentPlatform() => Theme.of(this).platform;

  /// text theme
  ///
  ///
  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;

  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;

  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;
}
