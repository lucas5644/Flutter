import 'dart:async';

import 'package:flutter_social/BLoC/bloc.dart';
import 'package:flutter_social/enums.dart';

class MenuStateBloc implements Bloc {
  MenuState? _menuState;
  MenuState? get selectedController => _menuState;

  final _menuStateController = StreamController<MenuState>.broadcast();

  Stream<MenuState> get menuStateStream => _menuStateController.stream;

  void notifyMenuStateChanged(MenuState menuState) {
    print(menuState);
    _menuState = menuState;
    _menuStateController.sink.add(menuState);
  }

  @override
  void dispose() {
    _menuStateController.close();
  }
}
