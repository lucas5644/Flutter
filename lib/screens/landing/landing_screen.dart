import 'package:flutter/material.dart';
import 'package:flutter_social/enums.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/screens/edit_profile/edit_profile_screen.dart';
import 'package:flutter_social/screens/feed/feed_screen.dart';
import 'package:flutter_social/screens/home/home_screen.dart';
import 'package:flutter_social/screens/notification/notification_screen.dart';
import 'package:flutter_social/screens/profile/profile_screen.dart';
import 'package:flutter_social/screens/write/write_screen.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/view/my_widgets/custom_floating_action_button.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  static String routeName = "/landing";
  final String? uid;

  const LandingScreen({Key? key, this.uid}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<MyUser?>(context);
    if (currentUser == null) {
      return LoadingScaffold();
    }
    return Consumer<MenuStateModel>(
      builder: (context, value, child) {
        return Scaffold(
          key: _globalKey,
          bottomNavigationBar: (value.menuState != MenuState.write && value.menuState != MenuState.edit)
              ? CustomBottomNavBar(
                  menuStateCurrent: value.menuState,
                )
              : null,
          body: _showPage(value.menuState),
          floatingActionButton: (value.menuState != MenuState.write && value.menuState != MenuState.edit)
              ? CustomFloatingActionButton(
                  myUser: currentUser,
                  currentMenuState: value.menuState,
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  _showPage(MenuState? menuState) {
    switch (menuState) {
      case MenuState.home:
        return HomeScreen();
      case MenuState.feed:
        return FeedScreen();
      case MenuState.notification:
        return NotificationScreen();
      case MenuState.profile:
        return ProfileScreen();
      case MenuState.write:
        return WriteScreen();
      case MenuState.edit:
        return EditProfilScreen();
      default:
        return HomeScreen();
    }
  }
}
