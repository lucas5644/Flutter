import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/view/my_material.dart';

class ProfileImage extends StatelessWidget {
  final MyUser myUser;
  final double? size;
  final Function? onTap;
  final double? initialesSize;

  const ProfileImage({Key? key, required this.myUser, this.size, this.onTap, this.initialesSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ImageProvider provider = CachedNetworkImageProvider(myUser.imageUrl!);
    return InkWell(
      onTap: onTap as void Function()?,
      child: (myUser.imageUrl != "")
          ? CircleAvatar(
              backgroundImage: provider,
              radius: size,
            )
          : Container(
              alignment: Alignment.center,
              width: size! * 2,
              height: size! * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange[300],
              ),
              child: Text(
                myUser.prenom[0] + myUser.nom[0],
                style: TextStyle(color: lTextColor, fontSize: initialesSize, fontWeight: FontWeight.w600),
              ),
            ),
    );
  }
}
