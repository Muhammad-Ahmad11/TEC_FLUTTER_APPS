import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:multimedia_app/controllers/home_controller.dart';
import 'package:multimedia_app/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: '/audio',
        onGenerateRoute: homeController.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.audio_file), label: 'Audio'),
            BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Image'),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_file), label: 'Video'),
          ],
          currentIndex: homeController.currentIndex.value,
          selectedItemColor: AppColors.backgroundColor,
          onTap: homeController.changePage,
          backgroundColor: AppColors.secondaryColor,
        );
      }),
    );
  }
}
