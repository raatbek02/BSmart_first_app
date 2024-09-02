import 'package:bsmart_first_app/core/common/widgets/custom_loading.dart';
import 'package:bsmart_first_app/core/common/widgets/product_card_v2.dart';
import 'package:bsmart_first_app/core/common/widgets/search_widget.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:bsmart_first_app/features/arrival/presentation/cubit/selected_products_cubit.dart';
import 'package:bsmart_first_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProductBloc>();
    bloc.add(FetchProductListEvent(
      organizationId: context.read<AuthBloc>().organizationId,
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
        title: const Text('Товары'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const CustomLoadingWidget();
              } else if (state is ProductLoaded) {
                return BlocBuilder<SelectedProductsCubit,
                    SelectedProductsState>(
                  builder: (context, selectedState) {
                    return ListView(
                      children: [
                        SearchWidget(),
                        SizedBox(height: 16.h),
                        ...state.product.content.map((product) {
                          final isSelected = selectedState.products
                              .any((p) => p.product.id == product.id);
                          return Column(
                            children: [
                              ProductCardV2(
                                productType: "Товар",
                                productName: product.name,
                                quantity: product.balanceStock,
                                price: product.sellingPrice,
                                productStatus: product.balanceStock > 0
                                    ? "Есть в наличии"
                                    : "Нет в наличии",
                                isSelected: isSelected,
                                onPressed: () {
                                  if (isSelected) {
                                    context
                                        .read<SelectedProductsCubit>()
                                        .removeProduct(product.id);
                                  } else {
                                    context
                                        .read<SelectedProductsCubit>()
                                        .addProduct(product);
                                  }
                                },
                              ),
                              SizedBox(height: 10.w),
                            ],
                          );
                        }),
                      ],
                    );
                  },
                );
              } else if (state is ProductError) {
                return Center(
                  child: Text(
                    state.message,
                  ),
                );
              } else {
                return const Center(child: Text('Нет данных'));
              }
            },
          ),
        ),
      ),
    );
  }
}




// class ProductsPage extends StatefulWidget {
//   const ProductsPage({super.key});

//   @override
//   State<ProductsPage> createState() => _ProductsPageState();
// }

// class _ProductsPageState extends State<ProductsPage> {
//   @override
//   void initState() {
//     super.initState();
//     final bloc = context.read<ProductBloc>();
//     bloc.add(FetchProductListEvent(
//       organizationId: context.read<AuthBloc>().organizationId,
//     ));
//   }

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
//         title: const Text('Товары'),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
//           child: BlocBuilder<ProductBloc, ProductState>(
//             builder: (context, state) {
//               if (state is ProductLoading) {
//                 return const CustomLoadingWidget();
//               } else if (state is ProductLoaded) {
//                 return ListView(
//                   children: [
//                     SearchWidget(),
//                     SizedBox(height: 16.h),
//                     ...state.product.content.map((product) {
//                       return Column(
//                         children: [
//                           ProductCardV2(
//                             // productType: product.categoryId,
//                             productType: "Товар",
//                             productName: product.name,
//                             quantity: product.balanceStock,
//                             price: product.sellingPrice,
//                             productStatus: product.balanceStock > 0
//                                 ? "Есть в наличии"
//                                 : "Нет в наличии",
//                             onPressed: () {
//                               context
//                                   .read<SelectedProductsCubit>()
//                                   .addProduct(product);
//                               logger.i("Product added");
//                             },
//                           ),
//                           SizedBox(height: 10.w),
//                         ],
//                       );
//                     }),
//                   ],
//                 );
//               } else if (state is ProductError) {
//                 return Center(
//                   child: Text(
//                     state.message,
//                   ),
//                 );
//               } else {
//                 return const Center(child: Text('Нет данных'));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// List of products FAILED: Exception: Failed to laod product list: FormatException: Invalid date format

// class ProductsPage extends StatefulWidget {
//   const ProductsPage({super.key});

//   @override
//   State<ProductsPage> createState() => _ProductsPageState();
// }

// class _ProductsPageState extends State<ProductsPage> {
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
//         title: const Text('Товары'),
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
//           child: ListView(
//             children: [
//               SearchWidget(),
//               SizedBox(height: 16.h),
//               ...productsList.map(
//                 (product) {
//                   return Column(
//                     children: [
//                       ProductCardV2(
//                         productType: product['productType'],
//                         productName: product['productName'],
//                         quantity: product['quantity'],
//                         price: product['price'],
//                         productStatus: product['productStatus'],
//                       ),
//                       SizedBox(height: 10.w),
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
