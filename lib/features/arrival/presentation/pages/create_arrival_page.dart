import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
import 'package:bsmart_first_app/core/common/widgets/product_card_v1.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/features/arrival/presentation/widgets/create_arrival_widgets/create_arrival_bottom_section.dart';
import 'package:bsmart_first_app/features/arrival/presentation/widgets/create_arrival_widgets/create_arrival_top_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateArrivalPage extends StatefulWidget {
  const CreateArrivalPage({super.key});

  @override
  State<CreateArrivalPage> createState() => _CreateArrivalPageState();
}

class _CreateArrivalPageState extends State<CreateArrivalPage> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Создание записи прихода'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: ListView(
            children: [
              CreateArrivalTopSection(),
              SizedBox(height: 16.h),
              const CreateArrivalBottomSection(),
            ],
          ),
        ),
      ),
    );
  }
}
