import 'package:flutter/material.dart';
import 'package:recipes_flutter/app/utils/widgets/responsive_text.dart';

class RoundedCornerButton extends StatefulWidget {
  final Function() onPressed;
  Color? buttonColor;
  String? title;
  double? roundedCorner;

  RoundedCornerButton({required this.onPressed, required this.buttonColor, this.roundedCorner, this.title, super.key});

  @override
  State<RoundedCornerButton> createState() => _RoundedCornerButtonState();
}

class _RoundedCornerButtonState extends State<RoundedCornerButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: widget.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              widget.roundedCorner!,
            ),
          ),
        ),
        onPressed: widget.onPressed,
        child: ResponsiveHeaderText(widget.title, const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)));
  }
}
