import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeStatisticsWidget extends StatelessWidget {
  const HomeStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/svg/demo_statistics.svg',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/svg/demo_statistics_under.svg',
            width: MediaQuery.of(context).size.width - 32.w,
          ),
        ),
      ],
    );
  }
}
