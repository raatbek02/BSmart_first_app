import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationItemCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;

  const NavigationItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Material(
        color: Colors
            .transparent, // Прозрачный цвет для сохранения цвета Container
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: onTap,
          splashColor: Colors.green.withOpacity(0.2), // Цвет эффекта нажатия
          highlightColor:
              Colors.green.withOpacity(0.1), // Цвет подсветки при нажатии
          child: ListTile(
            leading: icon,
            title: Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            trailing:
                const Icon(CupertinoIcons.right_chevron, color: Colors.green),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          ),
        ),
      ),
    );
  }
}
