import 'package:flutter/cupertino.dart';

import '../enums.dart';

class MenuStateModel extends ChangeNotifier {
  MenuState? _menuState = MenuState.home;
  MenuState? get menuState => _menuState;

  void notifyMenuStateChanged(MenuState? menuState) {
    print(menuState);
    _menuState = menuState;
    notifyListeners();
  }
}
