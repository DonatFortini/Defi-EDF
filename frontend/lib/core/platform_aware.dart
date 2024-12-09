import 'package:flutter/foundation.dart';

class PlatformAware {
  static bool get isWeb => kIsWeb;
  static bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  static bool get isDesktop =>
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows;

  // Platform-specific adaptations
  static T choose<T>({T? web, T? mobile, T? desktop, T? defaultValue}) {
    if (isWeb && web != null) return web;
    if (isMobile && mobile != null) return mobile;
    if (isDesktop && desktop != null) return desktop;

    return defaultValue as T;
  }
}
