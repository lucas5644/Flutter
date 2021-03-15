import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/view/my_material.dart';

class ProfileSpaceBar extends StatelessWidget {
  const ProfileSpaceBar({
    Key? key,
    required bool showTitle,
    required this.myUser,
  })   : _showTitle = showTitle,
        super(key: key);

  final bool _showTitle;
  final MyUser myUser;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: (_showTitle)
          ? Text(myUser.prenom + " " + myUser.nom, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600))
          : Text(""),
      background: Container(
        decoration: BoxDecoration(image: DecorationImage(image: couvertureImage, fit: BoxFit.cover, colorFilter: ColorFilter.linearToSrgbGamma())),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            ProfileImage(
              myUser: myUser,
              size: 60,
              onTap: () {},
              initialesSize: 45,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_showTitle)
                      ? SizedBox()
                      : Text(
                          myUser.prenom,
                          style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
