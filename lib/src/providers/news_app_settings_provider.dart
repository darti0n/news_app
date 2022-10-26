import 'package:flutter/material.dart';

class NewsAppSettingsProvider with ChangeNotifier {
  String _preferredLanguage = 'English';

  String get preferredLanguage => _preferredLanguage;

  void updatePreferredLanguage(String? preferredLanguage) {
    _preferredLanguage = preferredLanguage!;
    notifyListeners();
  }
}
