import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/features/arrival/presentation/cubit/selected_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class ProductCardV1 extends StatelessWidget {
  final ProductWithQuantity productWithQuantity;

  const ProductCardV1({
    Key? key,
    required this.productWithQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoRow("Товар: ", productWithQuantity.product.name),
            buildInfoRow('Остаток на складе: ',
                '${productWithQuantity.product.balanceStock.toInt()}'),
            buildQuantityAndPriceRow(context),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color.fromRGBO(79, 79, 79, 1)),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color.fromRGBO(24, 24, 24, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuantityAndPriceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildButton(
              icon: Icons.remove,
              onPressed: () {
                if (productWithQuantity.quantity > 1) {
                  context.read<SelectedProductsCubit>().updateProductQuantity(
                        productWithQuantity.product.id,
                        productWithQuantity.quantity - 1,
                      );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                '${productWithQuantity.quantity} шт',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _buildButton(
              icon: Icons.add,
              onPressed: () {
                if (productWithQuantity.quantity <
                    productWithQuantity.product.balanceStock.toInt()) {
                  context.read<SelectedProductsCubit>().updateProductQuantity(
                        productWithQuantity.product.id,
                        productWithQuantity.quantity + 1,
                      );
                }
              },
            ),
          ],
        ),
        Text(
          '${productWithQuantity.product.purchasePrice * productWithQuantity.quantity} KGS',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}




// class ProductCardV1 extends StatefulWidget {
//   final String productType;
//   final String productName;
//   final int quantity;
//   final double price;

//   const ProductCardV1({
//     super.key,
//     required this.productType,
//     required this.productName,
//     required this.quantity,
//     required this.price,
//   });

//   @override
//   _ProductCardV1State createState() => _ProductCardV1State();
// }

// class _ProductCardV1State extends State<ProductCardV1> {
//   late int currentQuantity;
//   late double totalPrice;

//   @override
//   void initState() {
//     super.initState();
//     // Set the initial quantity to 1
//     currentQuantity = 1;
//     // Initialize the total price based on the default quantity
//     totalPrice = widget.price * currentQuantity;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.zero,
//       elevation: 0,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.r),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInfoRow("${widget.productType}: ", widget.productName),
//             _buildInfoRow('Остаток на складе: ', '${widget.quantity}'),
//             _buildQuantityAndPriceRow()
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(color: Color.fromRGBO(79, 79, 79, 1)),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Color.fromRGBO(24, 24, 24, 1),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuantityAndPriceRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             _buildButtons(
//               icon: Icons.remove,
//               onPressed: () {
//                 if (currentQuantity > 1) {
//                   setState(() {
//                     currentQuantity--;
//                     totalPrice = widget.price * currentQuantity;
//                   });
//                   logger.i('Quantity decreased: $currentQuantity');
//                 }
//               },
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.w),
//               child: Text(
//                 '$currentQuantity шт',
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             _buildButtons(
//               icon: Icons.add,
//               onPressed: () {
//                 if (currentQuantity < widget.quantity) {
//                   setState(() {
//                     currentQuantity++;
//                     totalPrice = widget.price * currentQuantity;
//                   });
//                   logger.i('Quantity increased: $currentQuantity');
//                 }
//               },
//             ),
//           ],
//         ),
//         Text(
//           '$totalPrice KGS',
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildButtons({
//     required IconData icon,
//     required VoidCallback onPressed,
//   }) {
//     return Container(
//       width: 30.w,
//       height: 30.w,
//       decoration: BoxDecoration(
//         color: Colors.green,
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           splashColor: Colors.white.withOpacity(0.2),
//           highlightColor: Colors.white.withOpacity(0.1),
//           child: Center(
//             child: Icon(
//               icon,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// class ProductCardV1 extends StatefulWidget {
//   final String productType;
//   final String productName;
//   final int quantity;
//   final double price;

//   const ProductCardV1({
//     super.key,
//     required this.productType,
//     required this.productName,
//     required this.quantity,
//     required this.price,
//   });

//   @override
//   _ProductCardV1State createState() => _ProductCardV1State();
// }

// class _ProductCardV1State extends State<ProductCardV1> {
//   late int currentQuantity;

//   @override
//   void initState() {
//     super.initState();
//     currentQuantity = widget.quantity;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.zero,
//       elevation: 0,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.r),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInfoRow("${widget.productType}: ", widget.productName),
//             _buildInfoRow('Остаток на складе: ', '${widget.quantity}'),
//             _buildQuantityAndPriceRow()
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(color: Color.fromRGBO(79, 79, 79, 1)),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Color.fromRGBO(24, 24, 24, 1),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuantityAndPriceRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             _buildButtons(
//               icon: Icons.remove,
//               onPressed: () {
//                 if (currentQuantity > 0) {
//                   setState(() {
//                     currentQuantity--;
//                   });
//                   logger.i('Quantity decreased: $currentQuantity');
//                 }
//               },
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.w),
//               child: Text(
//                 '$currentQuantity шт',
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             _buildButtons(
//               icon: Icons.add,
//               onPressed: () {
//                 if (currentQuantity < widget.quantity) {
//                   setState(() {
//                     currentQuantity++;
//                   });
//                   logger.i('Quantity increased: $currentQuantity');
//                 }
//               },
//             ),
//           ],
//         ),
//         Text(
//           '${widget.price} KGS',
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildButtons({
//     required IconData icon,
//     required VoidCallback onPressed,
//   }) {
//     return Container(
//       width: 30.w,
//       height: 30.w,
//       decoration: BoxDecoration(
//         color: Colors.green,
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           splashColor: Colors.white.withOpacity(0.2),
//           highlightColor: Colors.white.withOpacity(0.1),
//           child: Center(
//             child: Icon(
//               icon,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
