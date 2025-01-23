import 'package:get/get.dart';

import '../controllers/language_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/theme_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Lazily loading controllers
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<LanguageController>(
        () => LanguageController()); // Optional, if you have one
  }
}
