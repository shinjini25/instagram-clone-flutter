import 'package:flutter/material.dart';
import '../utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  const ResponsiveLayout({Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
          return webScreenLayout;
        }
        //else
        return mobileScreenLayout;
      },
    );
  }
}
