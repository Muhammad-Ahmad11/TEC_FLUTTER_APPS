import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_07/routes/app_routes.dart';
import 'package:task_07/theme/theme.dart';
import 'package:task_07/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.initial,
      defaultTransition: Transition.fade,
      getPages: AppRoutes.routes,
    );
  }
}
