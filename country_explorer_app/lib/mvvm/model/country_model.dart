class CountryModel {
  final String name;
  final String flagUrl;
  final int population;
  final String capital;
  final String region;
  final List<double> latlng;

  CountryModel({
    required this.name,
    required this.flagUrl,
    required this.population,
    required this.capital,
    required this.region,
    required this.latlng,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name']['common'],
      flagUrl: json['flags']['png'],
      population: json['population'],
      capital: (json['capital'] != null &&
              json['capital'] is List &&
              json['capital'].isNotEmpty)
          ? json['capital'][0]
          : 'N/A',
      region: json['region'],
      latlng: List<double>.from(json['latlng']),
    );
  }
}
