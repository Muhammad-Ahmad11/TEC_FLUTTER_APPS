import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:task_04/mvvm/view_model/country_view_model.dart';
import 'package:task_04/utlis/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final countryController = Get.put(CountryViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            _buildCountryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              countryController.searchCountry(value);
            },
            decoration: const InputDecoration(
              hintText: Constants.hintSearchBar,
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Obx(() {
          return IconButton(
            onPressed: () {
              countryController.toggleShowFavoritesOnly();
            },
            icon: Icon(countryController.showFavOnly.value
                ? Icons.favorite
                : Icons.favorite_border),
          );
        }),
      ],
    );
  }

  Widget _buildCountryList() {
    return Expanded(
      child: Obx(() {
        if (countryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            itemCount: countryController.searchedCountries.length,
            itemBuilder: (context, index) {
              final country = countryController.searchedCountries[index];
              return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.network(country.flagUrl),
                  ),
                  title: Text(country.name),
                  subtitle: Text(Constants.regionText + country.region),
                  trailing: Obx(() {
                    return IconButton(
                      icon: Icon(
                        countryController.favCountries
                                .any((c) => c.name == country.name)
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      onPressed: () {
                        countryController.toggleFavourite(country);
                      },
                    );
                  }),
                  onTap: () {
                    Get.toNamed('/details', arguments: [country]);
                  });
            });
      }),
    );
  }
}
