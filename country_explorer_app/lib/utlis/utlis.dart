import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Utlis {
  static void showRemovedFromFavoritesSnackbar(String countryName) {
    Get.snackbar(
      'Removed from Favorites',
      '$countryName is no longer a favorite!',
    );
  }

  static void showAddedFromFavouriteSnackBar(String countryName) {
    Get.snackbar('Added to Favorites', '$countryName is now a favorite!');
  }

  static void failedToFindCountry() {
    Get.snackbar('Error', 'Failed to find coutry in list');
  }

  static void enterCountryName() {
    Get.snackbar('Error', 'Please enter country name to compare with');
  }
}
