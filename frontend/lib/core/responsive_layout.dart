import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

enum DeviceScreenType { mobile, tablet, desktop, web }

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? web;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.web,
  }) : super(key: key);

  static DeviceScreenType getDeviceType(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (kIsWeb) return DeviceScreenType.web;

    if (screenSize.width > 1200) return DeviceScreenType.desktop;
    if (screenSize.width > 600) return DeviceScreenType.tablet;

    return DeviceScreenType.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          return web ?? mobile;
        }

        if (Platform.isAndroid || Platform.isIOS) {
          return mobile;
        }

        if (constraints.maxWidth > 1200) {
          return desktop ?? tablet ?? mobile;
        }

        if (constraints.maxWidth > 600) {
          return tablet ?? mobile;
        }

        return mobile;
      },
    );
  }
}
