import 'package:flutter/material.dart';

import 'package:flutter_social/view/my_widgets/custom_app_bar.dart';

import '../../../enums.dart';
import 'list_view_users.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
            titre: "Utilisateurs",
            menuState: MenuState.home,
          ),
          ListViewUsers(),
        ],
      ),
    );
  }
}
