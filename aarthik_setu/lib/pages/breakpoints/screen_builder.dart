import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';



class ScreenBuilder extends StatelessWidget {
  const ScreenBuilder({super.key, required this.mobile, required this.desktop});

  final Widget mobile;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isMobile) {
          return mobile;
        } else {
          return desktop;
        }
      },
    );
  }
}
