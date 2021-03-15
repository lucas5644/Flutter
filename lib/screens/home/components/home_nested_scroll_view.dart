import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

import 'post_content.dart';

class HomeNestedScrollView extends StatefulWidget {
  const HomeNestedScrollView({Key? key}) : super(key: key);
  @override
  _HomeNestedScrollViewState createState() => _HomeNestedScrollViewState();
}

class _HomeNestedScrollViewState extends State<HomeNestedScrollView> {
  ScrollController? scrollController;
  double expanded = 200.0;
  bool get _showTitle {
    return scrollController!.hasClients && scrollController!.offset > expanded - kToolbarHeight;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(
        () {
          //Le setState permet de tout remettre à jour lors du scroll
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<MyUser?>(context);
    return NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CustomSliverAppBar(showTitle: _showTitle, userSelected: currentUser!, expanded: expanded),
          ];
        },
        body: PostContent(userConnected: currentUser!));
  }
}
