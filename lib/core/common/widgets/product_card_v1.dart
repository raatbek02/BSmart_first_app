import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardV1 extends StatefulWidget {
  final String productType;
  final String productName;
  final int quantity;
  final int price;
  final bool hasQuantity;

  const ProductCardV1({
    super.key,
    required this.productType,
    required this.productName,
    required this.quantity,
    required this.price,
    this.hasQuantity = true,
  });

  @override
  _ProductCardV1State createState() => _ProductCardV1State();
}

class _ProductCardV1State extends State<ProductCardV1> {
  late int currentQuantity;

  @override
  void initState() {
    super.initState();
    currentQuantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("${widget.productType}: ", widget.productName),
            _buildInfoRow('Остаток на складе: ', '${widget.quantity}'),
            if (widget.hasQuantity) _buildQuantityAndPriceRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color.fromRGBO(79, 79, 79, 1)),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color.fromRGBO(24, 24, 24, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityAndPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildQuantityButton(
              icon: Icons.remove,
              onPressed: () {
                if (currentQuantity > 0) {
                  setState(() {
                    currentQuantity--;
                  });
                  logger.i('Quantity decreased: $currentQuantity');
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                '$currentQuantity шт',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _buildQuantityButton(
              icon: Icons.add,
              onPressed: () {
                if (currentQuantity < widget.quantity) {
                  setState(() {
                    currentQuantity++;
                  });
                  logger.i('Quantity increased: $currentQuantity');
                }
              },
            ),
          ],
        ),
        Text(
          '${widget.price} KGS',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(
        color: Colors.green,
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
