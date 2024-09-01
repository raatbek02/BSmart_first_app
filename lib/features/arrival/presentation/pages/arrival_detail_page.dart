import 'package:bsmart_first_app/core/common/widgets/custom_loading.dart';
import 'package:bsmart_first_app/core/common/widgets/documents_card_widget.dart';
import 'package:bsmart_first_app/core/common/widgets/product_card_v2.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_detail_entity.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/arrival_detail_bloc/arrival_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrivalDetailPage extends StatefulWidget {
  final String organizationId;
  final String id;
  const ArrivalDetailPage(
      {super.key, required this.id, required this.organizationId});

  @override
  State<ArrivalDetailPage> createState() => _ArrivalDetailPageState();
}

class _ArrivalDetailPageState extends State<ArrivalDetailPage> {
  @override
  void initState() {
    super.initState();
    // Триггер события для загрузки данных при инициализации страницы
    final bloc = context.read<ArrivalDetailBloc>();
    bloc.add(FetchArrivalDetailEvent(
      organizationId: widget.organizationId,
      id: widget.id,
      forceRefresh: true,
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
        title: const Text('Карточка документа'),
      ),
      body: SafeArea(
        child: BlocBuilder<ArrivalDetailBloc, ArrivalDetailState>(
          builder: (context, state) {
            if (state is ArrivalDetailLoading) {
              return const CustomLoadingWidget();
            } else if (state is ArrivalDetailLoaded) {
              final arrivalDetail = state.arrivalDetail;
              return _buildArrivalDetailContent(arrivalDetail);
            } else if (state is ArrivalDetailError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text("Нет данных для отображения"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildArrivalDetailContent(ArrivalDetailEntity arrivalDetail) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                DocumentsCardWidget(
                  documentNumber: arrivalDetail.documentNumber,
                  // supplier: arrivalDetail.provider,
                  supplier: "Данил Усманов",

                  totalAmount: '${arrivalDetail.totalSum} KGS',
                  status: arrivalDetail.state,
                  showButton: false,
                  onDetailPressed: () {},
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 16.w,
                  endIndent: 16.w,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 10.w,
                    bottom: 16.w,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Товары",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 12.w),
                      ...arrivalDetail.purchases.map((purchase) {
                        return Column(
                          children: [
                            ProductCardV2(
                              productType: purchase.type ?? "Не указан",
                              productName: purchase.name,
                              quantity: purchase.amount,
                              price: purchase.price,
                              productStatus: purchase.balanceStock > 0
                                  ? "Есть в наличии"
                                  : "Нет в наличии",
                              showPlusButton: false,
                            ),
                            SizedBox(height: 12.w),
                          ],
                        );
                      }),
                      _buildInfoRow(
                        "Количество: ",
                        "${arrivalDetail.purchases.length} шт",
                      ),
                      _buildInfoRow(
                        "Итого закупочная: ",
                        "${arrivalDetail.purchases.fold<double>(0.0, (sum, item) => sum + (item.price * item.amount.toDouble()))} KGS",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color.fromRGBO(79, 79, 79, 1)),
          ),
          Text(
            value,
            style: TextStyle(
              color: const Color.fromRGBO(24, 24, 24, 1),
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// class ArrivalDetailPage extends StatefulWidget {
//   final String organizationId;
//   final String id;

//   const ArrivalDetailPage(
//       {super.key, required this.organizationId, required this.id});

//   @override
//   State<ArrivalDetailPage> createState() => _ArrivalDetailPageState();
// }

// class _ArrivalDetailPageState extends State<ArrivalDetailPage> {
//   final List<Map<String, dynamic>> productsList = [
//     {
//       'productType': 'Сумка',
//       'productName': 'Michael Kors',
//       'quantity': 24,
//       'price': 12000.0,
//       'productStatus': "Есть в наличии"
//     },
//     {
//       'productType': 'Сумка',
//       'productName': 'Michael Kors',
//       'quantity': 24,
//       'price': 12000.0,
//       'productStatus': "Есть в наличии"
//     },
//     {
//       'productType': 'Сумка',
//       'productName': 'Michael Kors',
//       'quantity': 24,
//       'price': 12000.0,
//       'productStatus': "Нет в наличии"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_rounded),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: const Text('Карточка документа'),

//         actions: [], // Icon for move to edit products page
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
//           child: ListView(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16.r),
//                 ),
//                 child: Column(
//                   children: [
//                     DocumentsCardWidget(
//                       documentNumber: "ПР-12345",
//                       supplier: "Данил Усманов",
//                       totalAmount: '2345.00 KGS',
//                       status: 'Черновик',
//                       showButton: false,
//                       onDetailPressed: () {},
//                     ),
//                     Divider(
//                       color: Colors.grey,
//                       thickness: 1,
//                       indent: 16.w,
//                       endIndent: 16.w,
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(
//                         left: 16.w,
//                         right: 16.w,
//                         top: 10.w,
//                         bottom: 16.w,
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 "Товары",
//                                 style: TextStyle(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 12.w),
//                           ...productsList.map(
//                             (product) {
//                               return Column(
//                                 children: [
//                                   ProductCardV2(
//                                     productType: product['productType'],
//                                     productName: product['productName'],
//                                     quantity: product['quantity'],
//                                     price: product['price'],
//                                     productStatus: product['productStatus'],
//                                     showPlusButton: false,
//                                   ),
//                                   SizedBox(height: 12.w),
//                                 ],
//                               );
//                             },
//                           ),
//                           _buildInfoRow("Количество: ", "3 шт"),
//                           _buildInfoRow("Итого закупочная: ", "36000 KGS"),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(color: Color.fromRGBO(79, 79, 79, 1)),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               color: const Color.fromRGBO(24, 24, 24, 1),
//               fontWeight: FontWeight.w600,
//               fontSize: 16.sp,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
