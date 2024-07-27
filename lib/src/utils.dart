import 'package:flutter/material.dart';

var doc = "assets/images/doc.png";
var xls = "assets/images/xls.png";
var pdf = "assets/images/pdf.png";

enum FileTypeEnum {
  pdf,
  doc,
  docx,
  xls,
  xlsx,
  png,
  jpg,
  jpeg,
}

class AppButton extends StatefulWidget {
  final String buttonTitle;
  final GestureTapCallback onTap;
  final Color? color;
  final Color? textColor;
  final double? textSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final bool isCourierFont;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
    this.color,
    this.textColor,
    this.textSize,
    this.letterSpacing,
    this.fontWeight,
    this.isCourierFont = false,
    this.padding,
    this.borderRadius,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: widget.color ?? Colors.white,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        ),
        child: Text(
          widget.buttonTitle,
          style: TextStyle(
            fontSize: widget.textSize ?? 13,
            fontWeight: widget.fontWeight ?? FontWeight.w600,
            color: widget.textColor ?? Colors.teal.shade400,
            letterSpacing: widget.letterSpacing ?? .8,
          ),
        ),
      ),
    );
  }
}
