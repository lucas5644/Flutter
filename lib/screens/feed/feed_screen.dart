import 'package:flutter/material.dart';

import 'components/body.dart';

class FeedScreen extends StatelessWidget {
  static String routeName = "/feed";

  const FeedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Body();
  }
}
