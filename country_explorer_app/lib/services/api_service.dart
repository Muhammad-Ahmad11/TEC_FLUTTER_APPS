import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_04/mvvm/model/country_model.dart';
import 'package:task_04/utlis/constants.dart';

class ApiService {
  static Future<List<CountryModel>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse(Constants.apiUrl));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;
        final countries = jsonResponse
            .map(
              (json) => CountryModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        return countries;
      } else {
        throw Exception('Failed to load countries');
      }
    } on Exception catch (e) {
      debugPrint('Error loading countries: $e');
      return [];
    }
  }
}
