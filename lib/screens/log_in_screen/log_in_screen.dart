import 'package:flutter/material.dart';
import 'package:flutter_social/provider/log_in_state_model.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class LogInScreen extends StatelessWidget {
  static String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => LogInStateModel(), child: Scaffold(body: Body()));
  }
}
