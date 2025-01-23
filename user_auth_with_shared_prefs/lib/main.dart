import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/models/auth_model.dart';
import 'package:task1/screens/splash_screen.dart';
import 'package:task1/theme/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      darkTheme: AppTheme.theme,
      supportedLocales: {const Locale('en', ' ')},
      home: SplashScreen(),
    );
  }
}
