import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/util/firestore_helper.dart';

import '../my_material.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    Key? key,
    required this.userSelected,
    required this.userConnected,
  }) : super(key: key);

  final MyUser userSelected;
  final MyUser? userConnected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 30,
      child: CustomButton(
        text: (userConnected!.abonnements.contains(userSelected.uid)) ? "abonné" : "s'abonner",
        onTap: () {
          FirestoreHelper().followUnfollowUser(userConnected!, userSelected);
        },
        border: (userConnected!.abonnements.contains(userSelected.uid)) ? true : false,
        buttonColor: (userConnected!.abonnements.contains(userSelected.uid)) ? Colors.transparent : null,
      ),
    );
  }
}
