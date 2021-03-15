import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/post.dart';

import 'components/body.dart';

class PostDetailScreen extends StatelessWidget {
  static String routeName = "/post-detail";
  const PostDetailScreen({Key? key}) : super();
  @override
  Widget build(BuildContext context) {
    final PostDetailArguments arguments = ModalRoute.of(context)!.settings.arguments as PostDetailArguments;
    return Scaffold(
      body: Body(userSelected: arguments.userSelected, post: arguments.post),
    );
  }
}

class PostDetailArguments {
  final MyUser userSelected;
  final Post post;

  PostDetailArguments(this.userSelected, this.post);
}
