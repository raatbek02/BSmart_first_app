// core/common/widgets/show_dynamic_modal_bottom.dart

import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void showDynamicModalBottom({
  required BuildContext context,
  required String title,
  required List<Map<String, String>> items,
  String? selectedValue,
  ValueChanged<String?>? onItemSelected,
}) {
  String? tempSelectedValue = selectedValue;

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    backgroundColor: Colors.white,
    elevation: 0,
    isScrollControlled: true,
    useRootNavigator: true,
    isDismissible: true,
    enableDrag: true,
    showDragHandle: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return DraggableScrollableSheet(
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return Stack(
                children: [
                  ListView(
                    controller: scrollController,
                    children: [
                      _buildModalHeader(context, title),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: Column(
                          children: items.map((item) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: SvgPicture.asset(
                                item['iconPath']!,
                                width: 24.w,
                                colorFilter: const ColorFilter.mode(
                                  Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              title: Text(
                                item['name']!,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              trailing: Radio<String>(
                                activeColor: Colors.green,
                                value: item['name']!,
                                groupValue: tempSelectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    tempSelectedValue = value;
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  tempSelectedValue = item['name'];
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20.w,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Отмена',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            textColor: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            backgroundColor: Colors.white,
                            padding: 7,
                            borderRadius: 16,
                            borderColor: Colors.black,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomButton(
                            text: 'Сохранить',
                            onPressed: () {
                              onItemSelected?.call(tempSelectedValue);
                              Navigator.pop(context, tempSelectedValue);
                            },
                            textColor: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            backgroundColor: Colors.green,
                            padding: 8,
                            borderRadius: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}

Widget _buildModalHeader(BuildContext context, String title) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    ),
  );
}
