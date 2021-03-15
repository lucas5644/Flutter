import 'package:flutter/material.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:provider/provider.dart';

import '../../enums.dart';

class CustomAppBar extends StatelessWidget {
  final String? titre;
  final Function? onTap;
  final MenuState? menuState;
  CustomAppBar({Key? key, this.titre, this.menuState, this.onTap});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: (menuState != null)
            ? () => Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(menuState)
            : onTap as void Function()?,
        child: Icon(Icons.arrow_back_rounded),
      ),
      elevation: 0,
      title: Text(titre!),
      centerTitle: true,
    );
  }
}
