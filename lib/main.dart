import 'package:beyond_the_pramids/core/navigation/app_route.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/core/services/theme_service.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupServiceLocator();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService.themeModeNotifier,
      builder: (context, themeMode, _) {
        final fontFamily =
            context.locale.languageCode == 'ar' ? 'Cairo' : 'Poppins';

        return MaterialApp(
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          themeMode: themeMode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF047185),
              brightness: Brightness.light,
            ),
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            cardColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF0E212F),
              elevation: 0,
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Color(0xFF047185),
              unselectedItemColor: Color(0xFF80909B),
            ),
            textTheme: Theme.of(
              context,
            ).textTheme.apply(fontFamily: fontFamily),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF047185),
              brightness: Brightness.dark,
            ),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0F1720),
            cardColor: const Color(0xFF19232D),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF0F1720),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF19232D),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF19232D),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFF304250)),
              ),
              hintStyle: const TextStyle(color: Color(0xFF8FA0AE)),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF19232D),
              selectedItemColor: Color(0xFF047185),
              unselectedItemColor: Color(0xFF93A3B2),
            ),
            textTheme: Theme.of(
              context,
            ).textTheme.apply(fontFamily: fontFamily),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/guideHomeRootView',
          onGenerateRoute: AppRoute.generate,
        );
      },
    );
  }
}
