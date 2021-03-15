import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/util/alert_helper.dart';
import 'package:flutter_social/view/my_material.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key? key,
    required this.myUser,
  }) : super(key: key);
  final MyUser myUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ProfileImage(
          myUser: myUser,
          size: 60,
          onTap: () {},
          initialesSize: 36,
        ),
        Positioned(
          bottom: -5,
          right: -10,
          child: GestureDetector(
            onTap: () {
              changePhoto(context, myUser);
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lPrimaryLightColor,
              ),
              child: Icon(Icons.add_a_photo_rounded),
            ),
          ),
        )
      ],
    );
  }
}
