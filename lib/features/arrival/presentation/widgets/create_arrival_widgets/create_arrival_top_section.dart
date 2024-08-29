import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
import 'package:bsmart_first_app/core/common/widgets/product_card_v1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateArrivalTopSection extends StatelessWidget {
  CreateArrivalTopSection({super.key});

  final List<Map<String, dynamic>> productsList = [
    {
      'productType': 'Сумка',
      'productName': 'Michael Kors',
      'quantity': 24,
      'price': 12000,
    },
    {
      'productType': 'Сумка',
      'productName': 'Michael Kors',
      'quantity': 24,
      'price': 12000,
    },
    {
      'productType': 'Сумка',
      'productName': 'Michael Kors',
      'quantity': 24,
      'price': 12000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          ...productsList.map((product) {
            return Column(
              children: [
                ProductCardV1(
                  productType: product['productType'],
                  productName: product['productName'],
                  quantity: product['quantity'],
                  price: product['price'],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 16.w,
                  endIndent: 16.w,
                ),
              ],
            );
          }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      "Количество: ",
                      style: TextStyle(
                        color: Color.fromRGBO(92, 95, 91, 1),
                      ),
                    ),
                    Text(
                      "3 шт",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Итого закупочная: ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color.fromRGBO(92, 95, 91, 1),
                      ),
                    ),
                    Text(
                      "36000 KGS",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  text: "Добавить товар",
                  backgroundColor: Colors.grey.shade200,
                  textColor: Colors.green,
                  fontSize: 14,
                  padding: 10,
                  borderRadius: 50,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
