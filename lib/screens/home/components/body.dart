import 'package:flutter/material.dart';

import 'home_nested_scroll_view.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HomeNestedScrollView(),
    );
  }
}
