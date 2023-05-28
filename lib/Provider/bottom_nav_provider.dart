import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  int _CurrentIndex = 0;

  int get currentIndex => _CurrentIndex;

  void changeIndex(int value) {
    _CurrentIndex = value;
    notifyListeners();
  }
}
