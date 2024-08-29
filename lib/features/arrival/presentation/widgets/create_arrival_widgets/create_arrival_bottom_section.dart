import 'package:bsmart_first_app/core/common/widgets/custom_text_field.dart';
import 'package:bsmart_first_app/core/common/widgets/select_button_widget.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateArrivalBottomSection extends StatefulWidget {
  const CreateArrivalBottomSection({super.key});

  @override
  State<CreateArrivalBottomSection> createState() =>
      _CreateArrivalBottomSectionState();
}

class _CreateArrivalBottomSectionState
    extends State<CreateArrivalBottomSection> {
  TextEditingController autorController =
      TextEditingController(text: 'Данил Усманов');
  TextEditingController documentNumberController =
      TextEditingController(text: 'ПР-12345');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Автор",
          isRequired: true,
          controller: autorController,
        ),
        SizedBox(height: 8.w),
        SelectButtonWidget(
          name: 'Выберите поставшика',
          nameSize: 14,
          label: 'Поставщик',
          labelSize: 14,
          isRequired: true,
          verticalPadding: 15,
          onTap: () {
            logger.i("Выберите поставщика");
          },
        ),
        SizedBox(height: 8.w),
        CustomTextField(
          label: "Номер документа",
          isRequired: true,
          controller: documentNumberController,
        ),
        SizedBox(height: 8.w),
        SelectButtonWidget(
          name: "Дата создания",
          nameSize: 14,
          label: "Дата",
          labelSize: 14,
          isRequired: true,
          verticalPadding: 16,
          nameColor: const Color.fromRGBO(153, 153, 153, 1),
          icon: Icons.calendar_month_outlined,
          iconColor: const Color.fromRGBO(153, 153, 153, 1),
          iconSize: 24,
          onTap: () {},
        ),
      ],
    );
  }
}
