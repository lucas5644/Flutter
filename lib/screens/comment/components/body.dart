import 'package:flutter/material.dart';
import 'package:flutter_social/enums.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/post.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final MyUser selectedUser;

  const Body({Key? key, required this.selectedUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Post? p = Provider.of<Post?>(context);
    return (p != null)
        ? SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    titre: "Laisser un commentaire...",
                    onTap: () {
                      Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.home);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: PostTile(author: selectedUser, post: p),
                  ),
                ],
              ),
            ),
          )
        : LoadingScaffold();
  }
}
