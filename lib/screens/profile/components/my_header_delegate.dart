import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/enums.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/util/alert_helper.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final MyUser userSelected;
  final MyUser? userConnected;
  final User? user;
  final VoidCallback? callback;
  final bool scrolled;

  MyHeaderDelegate(this.user, this.callback, this.scrolled, this.userSelected, this.userConnected);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.all(10.0),
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  (userSelected.description != null) ? userSelected.description! : "Aucune description",
                  style: TextStyle(color: lTextColor, fontSize: 15),
                ),
              ),
              (FirestoreHelper().authInstance.currentUser!.uid == userSelected.uid)
                  ? IconButton(
                      icon: Icon(logOutIcon, size: 30),
                      onPressed: () {
                        disconnect(context);
                      },
                    )
                  : FollowButton(userSelected: userSelected, userConnected: userConnected)
            ],
          ),
          Divider(color: Colors.black, height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "${userSelected.abonnements.length - 1}",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                  children: [
                    TextSpan(
                        text: (userSelected.abonnements.length <= 2) ? " Abonnement" : " Abonnements",
                        style: TextStyle(fontWeight: FontWeight.normal))
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  text: "${userSelected.abonnes.length - 1}",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                  children: [
                    TextSpan(text: (userSelected.abonnes.length <= 2) ? " Abonné" : " Abonnés", style: TextStyle(fontWeight: FontWeight.normal))
                  ],
                ),
              ),
              (userSelected.uid == FirestoreHelper().authInstance.currentUser!.uid)
                  ? GestureDetector(
                      onTap: () {
                        Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.edit);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.orange[600]!, width: 2)),
                        child: Text("Éditer mon profil", style: TextStyle(color: lTextColor, fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                    )
                  : Container(width: 150, height: 30)
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => (scrolled) ? 180.0 : 180.0;

  @override
  double get minExtent => (scrolled) ? 180.0 : 180.0;

  @override
  bool shouldRebuild(MyHeaderDelegate oldDelegate) => scrolled != oldDelegate.scrolled || user != oldDelegate.user;
}
