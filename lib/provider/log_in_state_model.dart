import 'package:flutter/material.dart';

class LogInStateModel extends ChangeNotifier {
  int? _page;
  int? get page => _page;

  void notifyPageChanged(int page) {
    _page = page;
    notifyListeners();
  }
}
