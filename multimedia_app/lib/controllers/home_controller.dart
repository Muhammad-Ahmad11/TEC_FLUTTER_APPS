import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_app/screens/audio_screen.dart';
import 'package:multimedia_app/screens/image_screen.dart';
import 'package:multimedia_app/screens/video_screen.dart';

class HomeController extends GetxController {
  final pages = <String>['/audio', '/image', '/video'];

  var currentIndex = 0.obs;

  void changePage(index) {
    currentIndex.value = index;
    //Get.toNamed(pages[index], id: 1);
    Get.offNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == '/audio') {
      return GetPageRoute(
        settings: routeSettings,
        page: () => const AudioScreen(),
      );
    } else if (routeSettings.name == '/image') {
      return GetPageRoute(
        settings: routeSettings,
        page: () => ImageScreen(),
      );
    } else if (routeSettings.name == '/video') {
      return GetPageRoute(
        settings: routeSettings,
        page: () => VideoScreen(),
      );
    } else {
      return null;
    }
  }
}
