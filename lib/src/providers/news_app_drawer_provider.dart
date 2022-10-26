import 'package:flutter/material.dart';

class NewsAppDrawerProvider with ChangeNotifier {
  int _drawerIndex = 1;

  int get drawerIndex => _drawerIndex;

  void updateDrawerIndex(int index) {
    _drawerIndex = index;
    notifyListeners();
  }
}
