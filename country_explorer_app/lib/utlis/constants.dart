class Constants {
  static const String apiUrl =
      "https://restcountries.com/v3.1/all?fields=name,flags,latlng,population,capital,region";

  static const String appName = "Country Explorer App";

  // main_screen strings
  static const String hintSearchBar = 'Search for a country';
  static const String regionText = "Region: ";

  // details screen strings
  static const String countryDetailsTitle = 'Country Details';
  static const String labelText = 'Enter Country to Compare with ';
  static const String hintText = 'e.g. United States';
  static const String compareBtnText = 'Compare';
  static const String comparisonText = 'Enter country names to compare';
  static const String populationText = 'Population: ';
  static const String capitalText = 'Capital: ';
  static const String coordinatesText = 'Coordinates: ';
  static const String showComparisonText = 'Show Comparison';
  static const String countryComparisonText = 'Country Comparison';
  static const String showCloseText = 'Close';

  // country view_models strings
  static const String boxName = 'favCountriesBox';
  static const String errFetchCountries = 'Error fetching countries: ';
  static const String doneFetching = 'Done fetching countries';
}
