import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:task_04/mvvm/view/details_screen.dart';
import 'package:task_04/mvvm/view/main_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => const MainScreen(),
    ),
    GetPage(
      name: '/details',
      page: () => const DetailsScreen(),
    ),
  ];
}
