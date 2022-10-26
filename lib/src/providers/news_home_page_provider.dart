import 'package:flutter/material.dart';
import 'package:news_app/src/utils/constants.dart';

class NewsHomePageProvider with ChangeNotifier {
  String _country = '';

  String get country => _country;

  void updateCountry(String country) {
    _country = NewsAppCountries.countryMap.keys
        .firstWhere((key) => NewsAppCountries.countryMap[key] == country);
    notifyListeners();
  }
}
