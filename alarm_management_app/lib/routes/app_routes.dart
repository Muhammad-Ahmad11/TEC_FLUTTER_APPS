import 'package:get/get.dart';
import 'package:task_07/views/alarm_screen.dart';

class AppRoutes {
  static const initial = '/home';

  static final routes = [
    GetPage(
      name: '/home',
      page: () => const AlarmScreen(),
    ),
  ];
}
