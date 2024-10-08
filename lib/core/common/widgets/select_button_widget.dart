import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectButtonWidget extends StatelessWidget {
  final String name;
  final Color nameColor;
  final double nameSize;
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final double verticalPadding;
  final String? label;
  final double labelSize;
  final bool isRequired;

  const SelectButtonWidget({
    super.key,
    required this.name,
    required this.onTap,
    this.verticalPadding = 12,
    this.icon = CupertinoIcons.chevron_down,
    this.nameColor = Colors.black,
    this.nameSize = 16,
    this.iconColor = Colors.black,
    this.iconSize = 22,
    this.label,
    this.labelSize = 16,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null)
          Row(
            children: [
              if (isRequired)
                Text(
                  '*',
                  style: TextStyle(color: Colors.red, fontSize: 16.sp),
                ),
              const SizedBox(width: 4),
              Padding(
                padding: EdgeInsets.only(bottom: 8.w),
                child: Text(
                  label!,
                  style: TextStyle(
                    color: const Color.fromRGBO(92, 95, 91, 1),
                    fontSize: labelSize.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: onTap,
            splashColor: Colors.green.withOpacity(0.2),
            highlightColor: Colors.green.withOpacity(0.1),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: verticalPadding.w, horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: nameColor,
                      fontSize: nameSize.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    icon,
                    color: iconColor,
                    size: iconSize.w,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
