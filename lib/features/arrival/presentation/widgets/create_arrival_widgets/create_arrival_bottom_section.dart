import 'package:bsmart_first_app/core/common/widgets/custom_text_field.dart';
import 'package:bsmart_first_app/core/common/widgets/select_button_widget.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateArrivalBottomSection extends StatefulWidget {
  const CreateArrivalBottomSection({super.key});

  @override
  State<CreateArrivalBottomSection> createState() =>
      _CreateArrivalBottomSectionState();
}

class _CreateArrivalBottomSectionState
    extends State<CreateArrivalBottomSection> {
  late TextEditingController autorController;

  @override
  void initState() {
    super.initState();
    autorController =
        TextEditingController(text: context.read<AuthBloc>().userName);
  }

  TextEditingController documentNumberController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Автор",
          isRequired: true,
          controller: autorController,
          readOnly: true,
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
          label: "Номер документа(Опционально)",
          isRequired: false,
          hintText: "Введите номер документа",
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
