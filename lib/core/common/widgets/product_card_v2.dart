import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardV2 extends StatelessWidget {
  final String productType;
  final String productName;
  final double quantity;
  final double price;
  final String productStatus;
  final bool showPlusButton;
  final VoidCallback onPressed;

  const ProductCardV2({
    super.key,
    required this.productType,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.productStatus,
    required this.onPressed,
    this.showPlusButton = true,
  });

  bool get isAvailable => productStatus != "Нет в наличии";

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: showPlusButton ? Colors.white : Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isAvailable)
              const Row(
                children: [
                  Text(
                    "Нет в наличии",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 122, 255, 1),
                    ),
                  )
                ],
              ),
            _buildInfoRow("$productType: ", productName, true),
            _buildInfoRow('Остаток на складе: ', '$quantity', false),
            _buildPriceRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool showPlusButtonInRow) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isAvailable
                      ? const Color.fromRGBO(79, 79, 79, 1)
                      : Colors.grey,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: isAvailable
                      ? const Color.fromRGBO(24, 24, 24, 1)
                      : Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (showPlusButton && showPlusButtonInRow)
            _buildButtons(
              icon: Icons.add,
              onPressed: isAvailable ? onPressed : null,
            ),
        ],
      ),
    );
  }

  Widget _buildPriceRow() {
    return Row(
      children: [
        Text(
          '$price KGS',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isAvailable ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
