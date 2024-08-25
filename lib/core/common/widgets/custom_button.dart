import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  // final Color backgroundColor;
  final Color textColor;
  final double padding;
  final double borderRadius;
  final double width;
  final double fontSize;
  final bool isBorder;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.padding = 15.0,
    this.borderRadius = 15,
    this.width = double.maxFinite,
    this.fontSize = 16,
    this.isBorder = true,
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
            color: const Color.fromRGBO(79, 174, 71, 1),
            borderRadius: BorderRadius.circular(borderRadius.r),
            border: isBorder
                ? Border.all(width: 2, color: Colors.grey.shade100)
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
                    fontWeight: FontWeight.bold,
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
