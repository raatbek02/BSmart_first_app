import 'package:bsmart_first_app/core/common/widgets/custom_loading.dart';
import 'package:bsmart_first_app/core/common/widgets/custom_text_field.dart';
import 'package:bsmart_first_app/core/common/widgets/select_button_widget.dart';
import 'package:bsmart_first_app/core/common/widgets/show_dynamic_modal_bottom.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/arrival_bloc/arrival_bloc.dart';
import 'package:bsmart_first_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CreateArrivalBottomSection extends StatefulWidget {
  final Function(String) onProviderSelected;
  final Function(String) onDocumentNumberChanged;
  final Function(DateTime) onDateSelected;

  const CreateArrivalBottomSection({
    super.key,
    required this.onProviderSelected,
    required this.onDocumentNumberChanged,
    required this.onDateSelected,
  });

  @override
  State<CreateArrivalBottomSection> createState() =>
      _CreateArrivalBottomSectionState();
}

class _CreateArrivalBottomSectionState
    extends State<CreateArrivalBottomSection> {
  late TextEditingController autorController;
  late TextEditingController documentNumberController;
  late DateTime selectedDate;

  Map<String, dynamic>? _selectedProvider;
  List<Map<String, dynamic>> _providerItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final String organizationId = context.read<AuthBloc>().organizationId;
    autorController =
        TextEditingController(text: context.read<AuthBloc>().userName);
    documentNumberController = TextEditingController(text: '');

    documentNumberController.addListener(() {
      widget.onDocumentNumberChanged(documentNumberController.text);
    });
    selectedDate = DateTime.now();

    // Запуск события для загрузки поставщиков
    context
        .read<ArrivalBloc>()
        .add(FetchProvidersEvent(organizationId: organizationId));
  }

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

        // Кнопка для выбора поставщика
        BlocListener<ArrivalBloc, ArrivalState>(
          listener: (context, state) {
            if (state is ProvidersLoaded) {
              setState(() {
                _providerItems = state.providers
                    .map((provider) => {
                          'name': provider.name,
                          'id': provider.id,
                          'iconPath': 'assets/svg/shop_icon.svg',
                        })
                    .toList();
                _isLoading = false;
              });
            } else if (state is ProvidersError) {
              setState(() {
                _isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('Ошибка загрузки поставщиков: ${state.message}')),
              );
            }
          },
          child: SelectButtonWidget(
            name: _selectedProvider?['name'] ?? 'Выберите поставщика',
            nameSize: 14,
            label: 'Поставщик',
            labelSize: 14,
            isRequired: true,
            verticalPadding: 15,
            onTap: () {
              if (_isLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Данные поставщиков еще загружаются')),
                );
              } else {
                showDynamicModalBottom(
                  context: context,
                  title: 'Выберите поставщика',
                  items: _providerItems,
                  selectedValue: _selectedProvider,
                  onItemSelected: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedProvider = {
                          'id': value['id'].toString(),
                          'name': value['name'].toString(),
                        };
                      });
                      widget.onProviderSelected(_selectedProvider!['id']!);
                    }
                  },
                );
              }
            },
          ),
        ),

        SizedBox(height: 8.w),

        // Поле ввода для номера документа
        CustomTextField(
          label: "Номер документа(Опционально)",
          isRequired: false,
          hintText: "Введите номер документа",
          controller: documentNumberController,
        ),

        SizedBox(height: 8.w),

        // Кнопка для выбора даты
        SelectButtonWidget(
          name: DateFormat('dd.MM.yyyy').format(selectedDate),
          nameSize: 14,
          label: "Дата",
          labelSize: 14,
          isRequired: true,
          verticalPadding: 16,
          nameColor: const Color.fromRGBO(153, 153, 153, 1),
          icon: Icons.calendar_month_outlined,
          iconColor: const Color.fromRGBO(153, 153, 153, 1),
          iconSize: 24,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
              widget.onDateSelected(picked); // Вызываем callback с новой датой
            }
          },
        ),
      ],
    );
  }
}
