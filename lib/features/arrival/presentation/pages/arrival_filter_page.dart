import 'package:bsmart_first_app/core/common/widgets/select_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrivalFilterPage extends StatefulWidget {
  const ArrivalFilterPage({super.key});

  @override
  State<ArrivalFilterPage> createState() => _ArrivalFilterPageState();
}

class _ArrivalFilterPageState extends State<ArrivalFilterPage> {
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
        title: const Text('Фильтр'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
          child: ListView(
            children: [
              SelectButtonWidget(
                name: "Выберите дату",
                onTap: () {},
                label: "Дата",
                verticalPadding: 16,
                nameColor: const Color.fromRGBO(153, 153, 153, 1),
                icon: Icons.calendar_month_outlined,
                iconColor: const Color.fromRGBO(153, 153, 153, 1),
                iconSize: 24,
              ),
              SizedBox(height: 16.h),
              SelectButtonWidget(
                name: "Выберите поставщика",
                onTap: () {},
                label: "Поставщик",
                verticalPadding: 16,
                nameColor: Color.fromARGB(255, 255, 249, 249),
                iconColor: const Color.fromRGBO(153, 153, 153, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


