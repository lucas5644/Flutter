import 'package:flutter/material.dart';

import 'components/body.dart';

class WriteScreen extends StatelessWidget {
  static String routeName = "/write";

  const WriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Body();
  }
}
