import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'bindings/bindings.dart';
import 'controllers/theme_controller.dart';
import 'views/navigation_page.dart';
import 'translations/app_translations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easypaisa Clone',
      theme: ThemeData.light(), // Default Light Theme
      darkTheme: ThemeData.dark(), // Dark Theme
      translations: AppTranslations(),
      locale: Get.deviceLocale, // Use device locale
      supportedLocales: const [Locale('en', 'US'), Locale('ur', 'PK')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      fallbackLocale: const Locale('en', 'US'), // Fallback if locale not found
      home: const NavigationPage(),
      initialBinding: InitialBindings(),
    );
  }
}
