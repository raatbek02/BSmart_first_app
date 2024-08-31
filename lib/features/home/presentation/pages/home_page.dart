import 'package:bsmart_first_app/core/common/widgets/show_dynamic_modal_bottom.dart';
import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:bsmart_first_app/features/home/presentation/widgets/home_navigations_widget.dart';
import 'package:bsmart_first_app/features/home/presentation/widgets/home_statistics_widget.dart';
import 'package:bsmart_first_app/features/home/presentation/widgets/store_and_date_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedStore;
  late String _userName;

  @override
  void initState() {
    super.initState();
    _userName = context.read<AuthBloc>().userName;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stores = [
      {'name': 'Bsmart shop', 'iconPath': 'assets/svg/shop_icon.svg'},
      {'name': 'Bruno Villa', 'iconPath': 'assets/svg/shop_icon.svg'},
      {'name': 'Mega Store', 'iconPath': 'assets/svg/shop_icon.svg'},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: CircleAvatar(
            radius: 32.w,
            backgroundImage:
                const AssetImage('assets/images/default_avatar.jpeg'),
            backgroundColor: Colors.grey.shade300,
          ),
        ),
        title: Text(
          _userName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/svg/notification_icon.svg',
              width: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
        child: ListView(
          children: [
            StoreAndDateSelection(
              onStoreTap: () => Future.delayed(
                const Duration(milliseconds: 200),
                () => showDynamicModalBottom(
                  context: context,
                  title: 'Выберите магазин',
                  items: stores,
                  selectedValue: _selectedStore,
                  onItemSelected: (value) {
                    setState(() {
                      _selectedStore = value;
                    });
                  },
                ),
              ),
              onMonthTap: () => Future.delayed(
                const Duration(milliseconds: 200),
                () => logger.i("ShowCalendarBottom"),
              ),
            ),
            SizedBox(height: 16.h),
            const HomeStatisticsWidget(),
            SizedBox(height: 16.h),
            const HomeNavigationsWidget(),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выход'),
          content: const Text('Вы уверены, что хотите выйти?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Выйти'),
              onPressed: () {
                Navigator.of(context).pop();
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
  }
}
