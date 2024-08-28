import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocumentsCardWidget extends StatelessWidget {
  final String documentNumber;
  final String supplier;
  final String totalAmount;
  final String status;
  final VoidCallback onDetailPressed;

  const DocumentsCardWidget({
    super.key,
    required this.documentNumber,
    required this.supplier,
    required this.totalAmount,
    required this.status,
    required this.onDetailPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Номер документа', documentNumber),
            _buildInfoRow('Поставщик', supplier),
            _buildInfoRow('Итого закупечная', totalAmount),
            _buildInfoRow('Статус', status, isStatus: true),
            CustomButton(
              text: 'Посмотреть подробно',
              onPressed: onDetailPressed,
              textColor: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              width: double.maxFinite,
              backgroundColor: const Color.fromRGBO(246, 247, 248, 1),
              padding: 5,
              borderRadius: 16,
              isBorder: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: const Color.fromRGBO(79, 79, 79, 1), fontSize: 16.sp)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              color: isStatus
                  ? const Color.fromRGBO(76, 178, 189, 1)
                  : const Color.fromRGBO(24, 24, 24, 1),
            ),
          ),
        ],
      ),
    );
  }
}
