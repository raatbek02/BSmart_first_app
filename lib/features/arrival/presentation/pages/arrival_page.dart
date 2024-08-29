import 'package:bsmart_first_app/core/common/widgets/documents_card_widget.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/core/routes/admin_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ArrivalPage extends StatefulWidget {
  const ArrivalPage({super.key});

  @override
  State<ArrivalPage> createState() => _ArrivalPageState();
}

class _ArrivalPageState extends State<ArrivalPage> {
  final List<Map<String, String>> documents = [
    {
      'documentNumber': 'ПР-12345',
      'supplier': 'Данил Усманов',
      'totalAmount': '2345.00 KGS',
      'status': 'Черновик',
    },
    {
      'documentNumber': 'ПР-12346',
      'supplier': 'Магнус Карсен',
      'totalAmount': '3500.00 KGS',
      'status': 'В обработке',
    },
    {
      'documentNumber': 'ПР-12347',
      'supplier': 'Анна Сидорова',
      'totalAmount': '1800.00 KGS',
      'status': 'Завершен',
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
        title: const Text('Приход товара'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/svg/filter.svg',
              height: 24.w,
            ),
            onPressed: () {
              context.push(AdminRoutes.arrivalFilterPage);
            },
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
          logger.i('Добавить приход товара');

          context.push(AdminRoutes.createArrivalPage);
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
