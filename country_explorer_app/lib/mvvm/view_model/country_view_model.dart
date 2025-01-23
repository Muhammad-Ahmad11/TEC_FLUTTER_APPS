import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:task_04/hive/hive_model.dart';
import 'package:task_04/mvvm/model/country_model.dart';
import 'package:task_04/services/api_service.dart';
import 'package:task_04/utlis/constants.dart';
import 'package:task_04/utlis/utlis.dart';

class CountryViewModel extends GetxController {
  var countries = <CountryModel>[].obs;
  var searchedCountries = <CountryModel>[].obs;
  var isLoading = true.obs;
  var favCountries = <Country>[].obs;
  late Box<Country> favCountriesBox;
  var firstCountry = Rx<CountryModel?>(null);
  var secondCountry = Rx<CountryModel?>(null);
  var showFavOnly = false.obs;

  @override
  void onInit() {
    favCountriesBox = Hive.box<Country>(Constants.boxName);
    favCountries.assignAll(favCountriesBox.values.toList());
    fetchCountries();
    super.onInit();
  }

  void fetchCountries() async {
    try {
      isLoading.value = true;
      var response = await ApiService.fetchCountries();
      countries.assignAll(response);
      searchedCountries.assignAll(response);
    } catch (e) {
      debugPrint(Constants.errFetchCountries + e.toString());
      isLoading.value = false;
    } finally {
      debugPrint(Constants.doneFetching);
      isLoading.value = false;
    }
  }

  void loadFavouriteCountries() {
    favCountries.assignAll(
      favCountriesBox.values.map((country) => Country(
            name: country.name,
            flagUrl: country.flagUrl,
            population: country.population,
            capital: country.capital,
            region: country.region,
            latlng: country.latlng,
          )),
    );
  }

  void searchCountry(String name) {
    if (showFavOnly.value) {
      searchedCountries.assignAll(
        countries.where((country) {
          final isFavorite =
              favCountries.any((fav) => fav.name == country.name);
          return isFavorite &&
              country.name.toLowerCase().contains(name.toLowerCase());
        }).toList(),
      );
    } else {
      searchedCountries.assignAll(
        countries
            .where(
              (country) => country.name.toLowerCase().contains(
                    name.toLowerCase(),
                  ),
            )
            .toList(),
      );
    }
  }

  void toggleShowFavoritesOnly() {
    showFavOnly.value = !showFavOnly.value;
    searchCountry('');
  }

  void toggleFavourite(CountryModel countryModel) {
    final hiveCountry = Country(
      name: countryModel.name,
      flagUrl: countryModel.flagUrl,
      population: countryModel.population,
      capital: countryModel.capital,
      region: countryModel.region,
      latlng: countryModel.latlng,
    );

    if (favCountries.any((c) => c.name == countryModel.name)) {
      favCountries.removeWhere((c) => c.name == countryModel.name);
      favCountriesBox.delete(countryModel.name);
      Utlis.showRemovedFromFavoritesSnackbar(countryModel.name);
    } else {
      favCountries.add(hiveCountry);
      favCountriesBox.put(countryModel.name, hiveCountry);
      Utlis.showAddedFromFavouriteSnackBar(countryModel.name);
    }
  }

  CountryModel? getCountryByName(String name) {
    try {
      return countries.firstWhere(
        (country) => country.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
