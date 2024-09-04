import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
import 'package:bsmart_first_app/core/common/widgets/search_widget.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/create_arrival_entity.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/arrival_bloc/arrival_bloc.dart';
import 'package:bsmart_first_app/features/arrival/presentation/cubit/selected_products_cubit.dart';
import 'package:bsmart_first_app/features/arrival/presentation/widgets/create_arrival_widgets/create_arrival_bottom_section.dart';
import 'package:bsmart_first_app/features/arrival/presentation/widgets/create_arrival_widgets/create_arrival_top_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateArrivalPage extends StatefulWidget {
  final String organizationId;
  final String userName;

  const CreateArrivalPage({
    super.key,
    required this.organizationId,
    required this.userName,
  });

  @override
  State<CreateArrivalPage> createState() => _CreateArrivalPageState();
}

class _CreateArrivalPageState extends State<CreateArrivalPage> {
  String? _selectedProviderId;
  String _documentNumber = '0'; // По умолчанию 0
  DateTime _selectedDate = DateTime.now();

  bool get isSubmitButtonEnabled {
    final selectedProductsState = context.read<SelectedProductsCubit>().state;
    return _selectedProviderId != null &&
        selectedProductsState.products.isNotEmpty;
  }

  void _handleProviderSelected(String providerId) {
    setState(() {
      _selectedProviderId = providerId;
    });
  }

  void _handleDocumentNumberChanged(String documentNumber) {
    setState(() {
      _documentNumber = documentNumber.isNotEmpty ? documentNumber : '0';
    });
  }

  void _handleDateSelected(DateTime date) {
    // Добавляем новый метод
    setState(() {
      _selectedDate = date;
    });
  }

  Future<void> _submitArrival() async {
    if (!isSubmitButtonEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не выбран поставщик или продукты')),
      );
      return;
    }
    final selectedProductsState = context.read<SelectedProductsCubit>().state;
    final organizationId = widget.organizationId;
    final author = widget.userName;

    final createArrivalEntity = CreateArrivalEntity(
      organizationId: organizationId,
      state: "RECORDED",
      type: "DELIVERY",
      byCash: selectedProductsState.totalPurchasePrice,
      change: 0,
      author: author,
      dateTime: _selectedDate,
      documentNumber: int.tryParse(_documentNumber) ?? 0,
      provider: _selectedProviderId ?? "",
      id: null,
      purchases: selectedProductsState.products.map((productWithQuantity) {
        return PurchaseEntity(
          productStockId: productWithQuantity.product.productStockId,
          amount: productWithQuantity.quantity.toDouble(),
          price: productWithQuantity.product.purchasePrice,
          sum: productWithQuantity.quantity *
              productWithQuantity.product.purchasePrice,
          discount: 0,
          sellingPrice: productWithQuantity.product.sellingPrice,
          type: "BOOKING",
          bundle: false,
          service: productWithQuantity.product.service,
        );
      }).toList(),
      totalSumFinal: selectedProductsState.totalPurchasePrice,
      totalDiscount: 0,
      byCashless: 0,
      count: selectedProductsState.totalQuantity,
      totalSum: selectedProductsState.totalPurchasePrice,
    );

    context.read<ArrivalBloc>().add(CreateArrivalEvent(
          organizationId: organizationId,
          arrival: createArrivalEntity,
        ));
  }

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
              const CreateArrivalTopSection(),
              SizedBox(height: 16.h),
              CreateArrivalBottomSection(
                onProviderSelected: _handleProviderSelected,
                onDocumentNumberChanged: _handleDocumentNumberChanged,
                onDateSelected: _handleDateSelected,
              ),
              SizedBox(height: 20.h),
              CustomButton(
                text: "Оприходовать",
                padding: 14,
                onPressed: isSubmitButtonEnabled ? _submitArrival : null,
                backgroundColor: isSubmitButtonEnabled
                    ? const Color.fromRGBO(79, 174, 71, 1)
                    : Colors.grey.shade400,
                textColor:
                    isSubmitButtonEnabled ? Colors.white : Colors.grey.shade700,
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
