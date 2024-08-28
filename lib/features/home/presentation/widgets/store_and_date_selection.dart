import 'package:bsmart_first_app/core/common/widgets/select_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreAndDateSelection extends StatelessWidget {
  final VoidCallback onStoreTap;
  final VoidCallback onMonthTap;

  const StoreAndDateSelection({
    super.key,
    required this.onStoreTap,
    required this.onMonthTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Кнопка для выбора магазина
        Expanded(
          flex: 6,
          child: SelectButtonWidget(
            name: 'Магазины',
            onTap: onStoreTap,
          ),
        ),
        SizedBox(width: 16.w),
        // Кнопка для выбора месяца
        Expanded(
          flex: 4,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: onMonthTap,
              splashColor: Colors.green.withOpacity(0.2),
              highlightColor: Colors.green.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.black,
                      size: 24.w,
                    ),
                    Text(
                      'Август',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
