import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/notification.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var notifs = Provider.of<List<Notif>>(context);
    var users = Provider.of<List<MyUser>>(context);

    return (notifs.isEmpty || users.isEmpty)
        ? Column(
            children: [
              CustomAppBar(titre: "Notifications"),
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
            ],
          )
        : SafeArea(
            child: Column(
              children: [
                CustomAppBar(titre: "Notifications"),
                Expanded(
                  child: ListView.builder(
                    itemCount: notifs.length,
                    itemBuilder: (context, index) {
                      Notif notif = notifs[index];
                      MyUser author = users.singleWhere((element) => element.uid == notif.expediteur);
                      return Column(
                        children: [
                          Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: Container(
                              child: ListTile(
                                leading: ProfileImage(myUser: author, size: 20),
                                title: Text(
                                  notif.notification!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            actions: [
                              IconSlideAction(
                                icon: Icons.delete_outline_rounded,
                                onTap: () {
                                  FirestoreHelper().deleteNotification(notif.documentId);
                                },
                                caption: "Supprimer",
                                color: Colors.red[300],
                              ),
                            ],
                          ),
                          Divider(color: Colors.black),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
