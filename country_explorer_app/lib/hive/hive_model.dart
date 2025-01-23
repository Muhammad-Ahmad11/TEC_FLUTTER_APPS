import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class Country {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String flagUrl;

  @HiveField(2)
  final String region;

  @HiveField(3)
  final String capital;

  @HiveField(4)
  final int population;

  @HiveField(5)
  final List<double> latlng;

  Country({
    required this.name,
    required this.flagUrl,
    required this.region,
    required this.capital,
    required this.population,
    required this.latlng,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      flagUrl: json['flags']['png'],
      region: json['region'],
      capital: json['capital']?.first ?? 'N/A',
      population: json['population'],
      latlng: List<double>.from(json['latlng']),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
