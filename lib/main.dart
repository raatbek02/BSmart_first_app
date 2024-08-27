import 'package:bsmart_first_app/core/di/app_bloc_providers.dart';
import 'package:bsmart_first_app/core/routes/app_router.dart';
import 'package:bsmart_first_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:bsmart_first_app/core/di/locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProviders(
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(411.42857142857144, 890.2857142857143),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, snapshot) {
          return MaterialApp.router(
            routerConfig: routerInit,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            title: 'BSmart',
            debugShowCheckedModeBanner: false,
            theme: CustomTheme.theme,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              SfGlobalLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ru', 'RU'),
            ],
          );
        },
      ),
    );
  }
}
