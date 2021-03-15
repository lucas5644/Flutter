import 'package:flutter/material.dart';
import 'package:flutter_social/enums.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  final MenuState? menuStateCurrent;

  const CustomBottomNavBar({Key? key, this.menuStateCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(0, -10),
            color: Color(0xFFDADADA).withOpacity(0.20),
          )
        ],
      ),
      child: Consumer<MenuStateModel>(
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(
                    homeIcon,
                    size: (value.menuState == MenuState.home || value.menuState == null) ? 35 : 30,
                    color: (value.menuState == MenuState.home || value.menuState == null) ? Colors.orange[500] : inActiveIconColor,
                  ),
                  onPressed: () {
                    Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.home);
                  }),
              IconButton(
                  icon: Icon(
                    feedIcon,
                    size: (value.menuState == MenuState.feed) ? 35 : 30,
                    color: value.menuState == MenuState.feed ? Colors.orange[500] : inActiveIconColor,
                  ),
                  onPressed: () {
                    Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.feed);
                  }),
              IconButton(
                  icon: Icon(
                    notifIcon,
                    size: (value.menuState == MenuState.notification) ? 35 : 30,
                    color: value.menuState == MenuState.notification ? Colors.orange[500] : inActiveIconColor,
                  ),
                  onPressed: () {
                    Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.notification);
                  }),
              IconButton(
                  icon: Icon(
                    profilIcon,
                    size: (value.menuState == MenuState.profile) ? 35 : 30,
                    color: value.menuState == MenuState.profile ? Colors.orange[500] : inActiveIconColor,
                  ),
                  onPressed: () {
                    Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.profile);
                  }),
            ],
          );
        },
      ),
    );
  }
}
