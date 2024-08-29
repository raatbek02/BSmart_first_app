import 'package:bsmart_first_app/core/common/widgets/product_card_v1.dart';
import 'package:bsmart_first_app/core/common/widgets/product_card_v2.dart';
import 'package:bsmart_first_app/core/common/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final List<Map<String, dynamic>> productsList = [
    {
      'productType': 'Сумка',
      'productName': 'Michael Kors',
      'quantity': 24,
      'price': 12000,
      'productStatus': "Есть в наличии"
    },
    {
      'productType': 'Сумка',
      'productName': 'Michael Kors',
      'quantity': 24,
      'price': 12000,
      'productStatus': "Есть в наличии"
    },
    {
      'productType': 'Сумка',
      'productName': 'Michael Kors',
      'quantity': 24,
      'price': 12000,
      'productStatus': "Нет в наличии"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Товары'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          child: ListView(
            children: [
              SearchWidget(),
              SizedBox(height: 16.h),
              ...productsList.map(
                (product) {
                  return Column(
                    children: [
                      ProductCardV2(
                        productType: product['productType'],
                        productName: product['productName'],
                        quantity: product['quantity'],
                        price: product['price'],
                        productStatus: product['productStatus'],
                      ),
                      SizedBox(height: 10.w),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
