import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWrapper({
    required this.mobile,
    required this.tablet,
    required this.desktop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1000) {
      return desktop;
    } else if (width >= 600) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
