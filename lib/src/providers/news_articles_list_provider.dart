import 'package:flutter/material.dart';

class NewsArticlesListProvider with ChangeNotifier {
  String _queryString = '';

  String get queryString => _queryString;

  String _errorMsg = '';

  String get errorMsg => _errorMsg;

  void updateQueryString(String qString) {
    _queryString = qString.replaceAll(' ', '+');
    notifyListeners();
  }

  void updateErrorMsg(String errorMsg) {
    _errorMsg = errorMsg;
    notifyListeners();
  }
}
