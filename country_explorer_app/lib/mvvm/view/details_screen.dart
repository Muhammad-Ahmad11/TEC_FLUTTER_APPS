import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task_04/mvvm/model/country_model.dart';
import 'package:task_04/mvvm/view_model/country_view_model.dart';
import 'package:task_04/theme/colors.dart';
import 'package:task_04/utlis/constants.dart';
import 'package:task_04/utlis/utlis.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final countryController = Get.put(CountryViewModel());

  List<CountryModel> countryModel = Get.arguments;
  final TextEditingController _firstCountryName = TextEditingController();
  RxList<String> suggestions = RxList<String>();

  @override
  void dispose() {
    _firstCountryName.dispose();
    countryController.firstCountry.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(Constants.countryDetailsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstCountryName,
              decoration: InputDecoration(
                labelText: Constants.labelText + countryModel[0].name,
                hintText: Constants.hintText,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                suggestions.value = countryController.countries
                    .where((country) => country.name
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .map((country) => country.name)
                    .toList();
              },
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (suggestions.isNotEmpty) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor,
                  ),
                  height: 200,
                  child: ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          suggestions[index],
                          style:
                              const TextStyle(color: AppColors.backgroundColor),
                        ),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          _firstCountryName.text = suggestions[index];
                          suggestions.clear();
                          _getCountriesDetails();
                          if (countryController.firstCountry.value != null) {
                            _showComparisonDialog(
                              countryController.firstCountry.value!,
                              countryModel[0],
                            );
                          } else {
                            Utlis.failedToFindCountry();
                          }
                        },
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            ElevatedButton(
              onPressed: () {
                if (countryController.firstCountry.value != null) {
                  _showComparisonDialog(
                    countryController.firstCountry.value!,
                    countryModel[0],
                  );
                } else {
                  Utlis.failedToFindCountry();
                }
              },
              child: const Text(
                Constants.showComparisonText,
                style: TextStyle(color: AppColors.backgroundColor),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GetX<CountryViewModel>(builder: (_) {
                if (countryController.firstCountry.value != null) {
                  return _markCountriesOnMap();
                } else {
                  return const Center(child: Text(Constants.comparisonText));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _getCountriesDetails() {
    final country1 = _firstCountryName.text.trim();

    if (country1.isNotEmpty) {
      final firstCountryDetails = countryController.getCountryByName(country1);
      if (firstCountryDetails != null) {
        countryController.firstCountry.value = firstCountryDetails;
      } else {
        Utlis.failedToFindCountry();
      }
    } else {
      Utlis.enterCountryName();
    }
  }

  void _showComparisonDialog(CountryModel country1, CountryModel country2) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(Constants.countryComparisonText),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildCountryInfo(country1),
                const Divider(),
                _buildCountryInfo(country2),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                Constants.showCloseText,
                style: TextStyle(color: AppColors.backgroundColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _markCountriesOnMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          (countryController.firstCountry.value!.latlng[0] +
                  countryModel[0].latlng[0]) /
              2,
          (countryController.firstCountry.value!.latlng[1] +
                  countryModel[0].latlng[1]) /
              2,
        ),
        zoom: 3,
      ),
      markers: {
        Marker(
          markerId: MarkerId(countryController.firstCountry.value!.name),
          position: LatLng(countryController.firstCountry.value!.latlng[0],
              countryController.firstCountry.value!.latlng[1]),
          infoWindow:
              InfoWindow(title: countryController.firstCountry.value!.name),
        ),
        Marker(
          markerId: MarkerId(countryModel[0].name),
          position:
              LatLng(countryModel[0].latlng[0], countryModel[0].latlng[1]),
          infoWindow: InfoWindow(title: countryModel[0].name),
        ),
      },
    );
  }

  Widget _buildCountryInfo(CountryModel country) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              country.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(Constants.regionText + country.region),
            Text(Constants.capitalText + country.capital),
            Text(Constants.populationText + country.population.toString()),
            const SizedBox(height: 8),
            Text(
              '${Constants.coordinatesText}${country.latlng[0]}, ${country.latlng[1]})',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
