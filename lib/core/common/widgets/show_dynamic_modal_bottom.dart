

// core/common/widgets/show_dynamic_modal_bottom.dart

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
      return DraggableScrollableSheet(
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return ListView(
            controller: scrollController,
            children: [
              _buildModalHeader(context, title),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                        groupValue: selectedValue,
                        onChanged: onItemSelected,
                      ),
                      onTap: () {
                        onItemSelected?.call(item['name']);
                        Navigator.pop(context, item['name']);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
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
