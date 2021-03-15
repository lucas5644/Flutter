import 'dart:async';

import 'bloc.dart';

class HeaderBloc implements Bloc {
  int? _page;
  int? get selectedController => _page;

  final _pageController = StreamController<int>();

  Stream<int> get pageStream => _pageController.stream;

  void notifyPageChanged(int page) {
    _page = page;
    _pageController.sink.add(page);
  }

  @override
  void dispose() {
    _pageController.close();
  }
}
