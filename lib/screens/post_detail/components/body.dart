import 'package:flutter/material.dart';
import 'package:flutter_social/BLoC/bloc_provider.dart';
import 'package:flutter_social/BLoC/menu_state_bloc.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/post.dart';
import 'package:flutter_social/view/my_material.dart';

import '../../../enums.dart';

class Body extends StatelessWidget {
  final MyUser userSelected;
  final Post? post;

  const Body({Key? key, required this.userSelected, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
              titre: "Discussion",
              onTap: () {
                BlocProvider.of<MenuStateBloc>(context).notifyMenuStateChanged(MenuState.home);
                Navigator.pop(context);
              }),
          ListTile(title: PostTile(author: userSelected, post: post)),
        ],
      ),
    );
  }
}
