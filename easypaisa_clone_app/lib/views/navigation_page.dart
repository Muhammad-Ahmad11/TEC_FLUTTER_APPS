import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_08/controllers/navigation_controller.dart';
import 'package:task_08/theme/colors.dart';
import 'package:task_08/views/menu_page.dart';
import 'home_page.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        return Scaffold(
          /**
           * Indexed Stack allows us to manage multiple child widgets, while keeping all the
           * others in the memory. It allows us to switch between multiple views without 
           * rebuilding them every time we switch. It preserves state, prevents building the 
           * widgets unnecessarily, which improves performance and reduces lag in navigation.
           */
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              const HomePage(),
              MenuPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.secondaryColor,
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.backgroundColor,
            onTap: (index) => controller.updateIndex(index),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: AppColors.backgroundColor,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                    color: AppColors.backgroundColor,
                  ),
                  label: 'Menu'),
            ],
          ),
        );
      },
    );
  }
}
