import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  // final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double width;
  final Color backgroundColor;
  final double padding;
  final double borderRadius;
  final bool isBorder;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.width = double.maxFinite,
    this.backgroundColor = const Color.fromRGBO(79, 174, 71, 1),
    this.padding = 15.0,
    this.borderRadius = 15,
    this.isBorder = true,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(borderRadius.r),
        onTap: onPressed,
        child: Ink(
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius.r),
            border: isBorder
                ? Border.all(
                    width: 1,
                    color: borderColor == null
                        ? Colors.grey.shade100
                        : borderColor!,
                  )
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: padding.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    color: textColor,
                    fontWeight: fontWeight,
                    fontSize: fontSize.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
