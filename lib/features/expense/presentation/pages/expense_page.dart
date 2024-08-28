import 'package:bsmart_first_app/core/common/widgets/documents_card_widget.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final List<Map<String, String>> documents = [
    {
      'documentNumber': 'ПР-12347',
      'supplier': 'Анна Сидорова',
      'totalAmount': '1800.00 KGS',
      'status': 'Завершен',
    },
    {
      'documentNumber': 'ПР-12346',
      'supplier': 'Иван Петров',
      'totalAmount': '3500.00 KGS',
      'status': 'В обработке',
    },
    {
      'documentNumber': 'ПР-12345',
      'supplier': 'Данил Усманов',
      'totalAmount': '2345.00 KGS',
      'status': 'Черновик',
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
        title: const Text('Расход товара'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/svg/filter.svg',
              height: 24.w,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
          child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final doc = documents[index];
                return DocumentsCardWidget(
                  documentNumber: doc['documentNumber']!,
                  supplier: doc['supplier']!,
                  totalAmount: doc['totalAmount']!,
                  status: doc['status']!,
                  // onTap: () {
                  //   logger.i("Карточка нажата: ${doc['documentNumber']}");
                  // },
                  onDetailPressed: () {
                    logger.i("Посмотреть подробно: ${doc['documentNumber']}");
                  },
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logger.i('Добавить расход');
        },
        backgroundColor: Colors.green,
        child: SvgPicture.asset(
          'assets/svg/plus.svg',
          width: 24.w,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
