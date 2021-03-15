import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/screens/profile/components/profile_space_bar.dart';

import '../my_material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
    required showTitle,
    required this.userSelected,
    required this.expanded,
  })  : _showTitle = showTitle,
        super(key: key);

  final bool _showTitle;
  final MyUser userSelected;
  final double expanded;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey[100],
      elevation: 0,
      leadingWidth: 60,
      pinned: true,
      leading: (_showTitle)
          ? Padding(
              padding: EdgeInsets.only(left: 14),
              child: ProfileImage(
                myUser: userSelected,
                size: 0,
              ),
            )
          : null,
      expandedHeight: expanded,
      actions: [],
      flexibleSpace: ProfileSpaceBar(showTitle: _showTitle, myUser: userSelected),
    );
  }
}
