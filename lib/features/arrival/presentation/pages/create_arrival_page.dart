import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
import 'package:bsmart_first_app/core/common/widgets/search_widget.dart';
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
        title: Text(
          'Создание записи прихода',
          style: TextStyle(fontSize: 18.sp),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: ListView(
            children: [
              SearchWidget(),
              SizedBox(height: 16.h),
              // CreateArrivalTopSection(),
              const CreateArrivalBottomSection(),

              SizedBox(height: 16.h),
              CreateArrivalTopSection(),
              // const CreateArrivalBottomSection(),

              SizedBox(height: 20.h),
              CustomButton(
                text: "Оприходовать",
                padding: 14,
                onPressed: () {
                  logger.i("Оприходовать");
                },
              ),
              SizedBox(height: 10.h),
              CustomButton(
                text: "Сохранить как черновик",
                textColor: Colors.green,
                backgroundColor: Colors.transparent,
                borderColor: Colors.grey,
                padding: 12,
                onPressed: () {
                  logger.i("Сохранить как черновик");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
