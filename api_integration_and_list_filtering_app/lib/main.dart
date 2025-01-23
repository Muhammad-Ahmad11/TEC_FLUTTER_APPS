import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:task_03/theme/theme.dart';
import 'package:task_03/views/post_view.dart';
import 'package:task_03/views/user_view.dart';
import 'package:task_03/views/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      darkTheme: AppTheme.theme,
      initialRoute: '/view',
      getPages: [
        GetPage(
          name: '/view',
          page: () => const ViewScreen(),
        ),
        GetPage(
          name: '/post-view',
          page: () => PostView(),
        ),
        GetPage(
          name: '/user-view',
          page: () => UserView(),
        ),
      ],
    );
  }
}
