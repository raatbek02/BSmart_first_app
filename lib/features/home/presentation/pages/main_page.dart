import 'package:bsmart_first_app/features/arrival/presentation/pages/arrival_page.dart';
import 'package:bsmart_first_app/features/expense/presentation/pages/expense_page.dart';
import 'package:bsmart_first_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  final int initialPage;
  const MainPage({
    super.key,
    this.initialPage = 0,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final currentIndex = ValueNotifier<int>(0);
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    currentIndex.value = widget.initialPage;
    _pageController = PageController(initialPage: currentIndex.value);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  List<Widget> get pages => const [
        HomePage(),
        ArrivalPage(),
        ExpensePage(),
        HomePage(),
      ];

  void onTap(int index) {
    currentIndex.value = index;
    _pageController?.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: pages,
          onPageChanged: (index) => currentIndex.value = index,
        ),
        bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: currentIndex,
          builder: (_, value, __) => BottomNavigationBar(
            currentIndex: value,
            onTap: onTap,
            backgroundColor: Colors.white,
            selectedLabelStyle: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              height: 1.8,
            ),

            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              height: 1.8,
            ),
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey.shade400,
            iconSize: 24.sp,
            type: BottomNavigationBarType.fixed, // Отключаем анимацию
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/bottom_navigation_icons/home_icon.svg',
                  height: 24.w, // Адаптируем размер иконок
                  colorFilter: ColorFilter.mode(
                    value == 0 ? Colors.green : Colors.grey.shade400,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/arrival_plus.svg',
                  height: 24.w, // Адаптируем размер иконок
                  colorFilter: ColorFilter.mode(
                    value == 1 ? Colors.green : Colors.grey.shade400,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Приход',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/expense_minus.svg',
                  height: 24.w, // Адаптируем размер иконок
                  colorFilter: ColorFilter.mode(
                    value == 2 ? Colors.green : Colors.grey.shade400,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Расход',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/bottom_navigation_icons/settings_icon.svg',
                  height: 24.w, // Адаптируем размер иконок
                  colorFilter: ColorFilter.mode(
                    value == 3 ? Colors.green : Colors.grey.shade400,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Настройки',
              ),
              //  selectedLabelStyle: TextStyle(fontSize: 12.sp),  // Адаптируем размер текста для выбранного элемента
            ],
          ),
        ),
      ),
    );
  }
}


// Товары и Отчеты

//  BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                   'assets/svg/bottom_navigation_icons/products_icon.svg',
//                   height: 24.w, // Адаптируем размер иконок
//                   colorFilter: ColorFilter.mode(
//                     value == 1 ? Colors.green : Colors.grey.shade400,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//                 label: 'Товары',
//               ),
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                   'assets/svg/bottom_navigation_icons/reports_icon.svg',
//                   height: 24.w, // Адаптируем размер иконок
//                   colorFilter: ColorFilter.mode(
//                     value == 2 ? Colors.green : Colors.grey.shade400,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//                 label: 'Отчеты',
//               ),