import 'package:bsmart_first_app/core/common/widgets/custom_button.dart';
import 'package:bsmart_first_app/core/common/widgets/product_card_v1.dart';
import 'package:bsmart_first_app/core/routes/admin_routes.dart';
import 'package:bsmart_first_app/features/arrival/presentation/cubit/selected_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';



class CreateArrivalTopSection extends StatelessWidget {
  const CreateArrivalTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: BlocBuilder<SelectedProductsCubit, SelectedProductsState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state.products.isNotEmpty) ...[
                ...state.products.map((productWithQuantity) {
                  return Column(
                    children: [
                      ProductCardV1(
                        productWithQuantity: productWithQuantity,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 16.w,
                        endIndent: 16.w,
                      ),
                    ],
                  );
                }),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Количество: ",
                            style: TextStyle(
                              color: Color.fromRGBO(92, 95, 91, 1),
                            ),
                          ),
                          Text(
                            "${state.totalQuantity} шт",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Итого закупочная: ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color.fromRGBO(92, 95, 91, 1),
                            ),
                          ),
                          Text(
                            "${state.totalPurchasePrice.toStringAsFixed(2)} KGS",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      CustomButton(
                        text: "Добавить товар",
                        backgroundColor: Colors.grey.shade200,
                        textColor: Colors.green,
                        fontSize: 14,
                        padding: 10,
                        borderRadius: 50,
                        onPressed: () {
                          context.push(AdminRoutes.productsPage);
                        },
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                  child: CustomButton(
                    text: "Добавить товар",
                    backgroundColor: Colors.grey.shade200,
                    textColor: Colors.green,
                    fontSize: 14,
                    padding: 10,
                    borderRadius: 50,
                    onPressed: () {
                      context.push(AdminRoutes.productsPage);
                    },
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}




// class CreateArrivalTopSection extends StatelessWidget {
//   const CreateArrivalTopSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//       ),
//       child: BlocBuilder<SelectedProductsCubit, List<ProductContentEntity>>(
//         builder: (context, selectedProducts) {
//           return Column(
//             children: [
//               if (selectedProducts.isNotEmpty) ...[
//                 ...selectedProducts.map((product) {
//                   return Column(
//                     children: [
//                       ProductCardV1(
//                         // productType: product.categoryId,
//                         productType: "Товар",
//                         productName: product.name,
//                         quantity: product.balanceStock.toInt(),
//                         price: product.purchasePrice,
//                       ),
//                       Divider(
//                         color: Colors.grey,
//                         thickness: 1,
//                         indent: 16.w,
//                         endIndent: 16.w,
//                       ),
//                     ],
//                   );
//                 }).toList(),
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "Количество: ",
//                             style: TextStyle(
//                               color: Color.fromRGBO(92, 95, 91, 1),
//                             ),
//                           ),
//                           Text(
//                             "${selectedProducts.length} шт",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "Итого закупочная: ",
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               color: const Color.fromRGBO(92, 95, 91, 1),
//                             ),
//                           ),
//                           Text(
//                             "${selectedProducts.fold(0, (total, product) => total + product.purchasePrice.toInt())} KGS",
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16.h),
//                       CustomButton(
//                         text: "Добавить товар",
//                         backgroundColor: Colors.grey.shade200,
//                         textColor: Colors.green,
//                         fontSize: 14,
//                         padding: 10,
//                         borderRadius: 50,
//                         onPressed: () {
//                           context.push(AdminRoutes.productsPage);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ] else ...[
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
//                   child: CustomButton(
//                     text: "Добавить товар",
//                     backgroundColor: Colors.grey.shade200,
//                     textColor: Colors.green,
//                     fontSize: 14,
//                     padding: 10,
//                     borderRadius: 50,
//                     onPressed: () {
//                       context.push(AdminRoutes.productsPage);
//                     },
//                   ),
//                 ),
//               ],
//             ],
//           );
//         },
//       ),
//     );
//   }
// }




// class CreateArrivalTopSection extends StatelessWidget {
//   CreateArrivalTopSection({super.key});

//   final List<Map<String, dynamic>> productsList = [
//     {
//       'productType': 'Сумка',
//       'productName': 'Michael Kors',
//       'quantity': 24,
//       'price': 12000,
//     },
//     {
//       'productType': 'Сумка',
//       'productName': 'Michael Kors',
//       'quantity': 24,
//       'price': 12000,
//     },
//     {
//       'productType': 'Сумка',
//       'productName': 'Michael Kors',
//       'quantity': 24,
//       'price': 12000,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//       ),
//       child: Column(
//         children: [
//           ...productsList.map((product) {
//             return Column(
//               children: [
//                 ProductCardV1(
//                   productType: product['productType'],
//                   productName: product['productName'],
//                   quantity: product['quantity'],
//                   price: product['price'],
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 16.w,
//                   endIndent: 16.w,
//                 ),
//               ],
//             );
//           }),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const Row(
//                   children: [
//                     Text(
//                       "Количество: ",
//                       style: TextStyle(
//                         color: Color.fromRGBO(92, 95, 91, 1),
//                       ),
//                     ),
//                     Text(
//                       "3 шт",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Итого закупочная: ",
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         color: const Color.fromRGBO(92, 95, 91, 1),
//                       ),
//                     ),
//                     Text(
//                       "36000 KGS",
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.h),
//                 CustomButton(
//                   text: "Добавить товар",
//                   backgroundColor: Colors.grey.shade200,
//                   textColor: Colors.green,
//                   fontSize: 14,
//                   padding: 10,
//                   borderRadius: 50,
//                   onPressed: () {
//                     context.push(AdminRoutes.productsPage);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
