import 'package:flutter/material.dart';

class ResponsiveAppBarText extends StatelessWidget {
  final text;
  TextStyle style;

  ResponsiveAppBarText(this.text, this.style, {super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine text size based on screen width (you can adjust the breakpoints as needed)
    double fontSize;
    if (screenWidth < 600) {
      // Mobile
      fontSize = 16;
    } else if (screenWidth < 1200) {
      // Tablet
      fontSize = 24;
    } else {
      // Desktop
      fontSize = 32;
    }

    return Text(
      text,
      style: style,
    );
  }
}
class ResponsiveHeaderText extends StatelessWidget {
  final text;
  TextStyle style;

  ResponsiveHeaderText(this.text, this.style, {super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine text size based on screen width (you can adjust the breakpoints as needed)
    double fontSize;
    if (screenWidth < 600) {
      // Mobile
      fontSize = 14;
    } else if (screenWidth < 1200) {
      // Tablet
      fontSize = 22;
    } else {
      // Desktop
      fontSize = 30;
    }

    return Text(
      text,
      style: style,
    );
  }
}