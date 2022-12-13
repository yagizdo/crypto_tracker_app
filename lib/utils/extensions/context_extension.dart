import 'dart:io';

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get _mediaQuery => MediaQuery.of(this);

  double getHeight(double ratio) => MediaQuery.of(this).size.height * ratio;
  double getWidth(double ratio) => MediaQuery.of(this).size.width * ratio;

  Size get size => MediaQuery.of(this).size;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get shortestSide =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .shortestSide;

  bool get isIpad =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .shortestSide >
      600;

  bool get isLittlePhone =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .shortestSide <
      330;

  bool get isAndroidPhone => Platform.isAndroid;

  bool get isBigAndroidPhone =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .shortestSide >
      390;
}
