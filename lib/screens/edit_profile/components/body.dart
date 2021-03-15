import 'package:flutter/material.dart';
import 'package:flutter_social/enums.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/view/my_widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import 'edit_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<MyUser?>(context);
    return (currentUser == null)
        ? LoadingScaffold()
        : SafeArea(
            child: Column(
              children: [
                CustomAppBar(menuState: MenuState.profile, titre: "Modifier mon profil"),
                EditForm(),
              ],
            ),
          );
  }
}
