import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

import '../../enums.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    Key? key,
    required this.myUser,
    required this.currentMenuState,
  }) : super(key: key);

  final MyUser myUser;
  final MenuState? currentMenuState;

  @override
  Widget build(BuildContext context) {
    MenuState? menuState = currentMenuState;
    return FloatingActionButton(
      clipBehavior: Clip.hardEdge,
      onPressed: () {
        if (menuState != MenuState.write) {
          Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.write);
        } else {
          Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.home);
          Navigator.pop(context);
        }
      },
      elevation: 0,
      backgroundColor: (menuState != MenuState.write) ? Colors.white : Colors.orange[400],
      child: Container(
        height: (menuState != MenuState.write) ? double.infinity : 48,
        width: (menuState != MenuState.write) ? double.infinity : 48,
        decoration: BoxDecoration(
          color: (menuState != MenuState.write) ? Colors.orange[400] : Colors.white,
          border: Border.all(color: (menuState == MenuState.write) ? Colors.orange[400]! : Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          writeIcon,
          color: (menuState != MenuState.write) ? Colors.white : Colors.orange[400],
        ),
      ),
    );
  }
}
