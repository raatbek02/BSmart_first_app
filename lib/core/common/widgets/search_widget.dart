import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});

  final List<String> mockProducts = [
    'Smartphone',
    'Apple',
    'Наушники',
    'Планшет',
    'Умные часы',
    'Фотоаппарат',
    'Телевизор',
    'Игровая консоль',
    'Принтер',
    'Монитор'
  ];

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Поиск товара',
            hintStyle: const TextStyle(color: Colors.black87),
            prefixIconConstraints: BoxConstraints(
              minWidth: 22.sp,
              minHeight: 22.sp,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 15.w,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                  left: 16.w, right: 10.w), // Добавляем отступ слева
              child: SvgPicture.asset(
                'assets/svg/search.svg',
                width: 22.sp,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(width: 1, color: Colors.grey),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
          ),
          style: const TextStyle(color: Colors.black),
        );
      },
      decorationBuilder: (context, child) {
        return Material(
          color: Colors.grey.shade100,
          child: child,
        );
      },
      suggestionsCallback: (pattern) async {
        return mockProducts
            .where((product) =>
                product.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSelected: (suggestion) {
        print('Выбран товар: $suggestion'); // Заменено logger.i на print
      },
      emptyBuilder: (context) => const ListTile(
        title: Text('Товары не найдены'),
      ),
      loadingBuilder: (context) => const ListTile(
        title: Text('Поиск...'),
      ),
      errorBuilder: (context, error) => ListTile(
        title: Text('Произошла ошибка: $error'),
      ),
    );
  }
}
