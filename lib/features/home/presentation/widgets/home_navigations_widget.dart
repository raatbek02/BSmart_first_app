import 'package:bsmart_first_app/core/common/widgets/navigation_item_card.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeNavigationsWidget extends StatelessWidget {
  const HomeNavigationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavigationItemCard(
          icon: SvgPicture.asset(
            'assets/svg/plus.svg',
            width: 22.w,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: 'Приход товара',
          onTap: () {
            _handleTap(() {
              logger.i("Приход товара");
            });
          },
        ),
        NavigationItemCard(
          icon: SvgPicture.asset(
            'assets/svg/minus.svg',
            width: 22.w,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: 'Расход товара',
          onTap: () {
            _handleTap(() {
              logger.i('Расход товара');
            });
          },
        ),
        NavigationItemCard(
          icon: SvgPicture.asset(
            'assets/svg/procent.svg',
            width: 22.w,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
          title: 'Начать опись',
          onTap: () {
            _handleTap(() {
              logger.i('Начать опись');
            });
          },
        ),
      ],
    );
  }

  void _handleTap(VoidCallback callback) {
    Future.delayed(
      const Duration(milliseconds: 200),
      callback,
    );
  }
}
