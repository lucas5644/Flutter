import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/notification.dart';
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
        : Column(
            children: [
              CustomAppBar(titre: "Notifications"),
              Expanded(
                child: ListView.builder(
                  itemCount: notifs.length,
                  itemBuilder: (context, index) {
                    Notif notif = notifs[index];
                    MyUser author = users.singleWhere((element) => element.uid == notif.expediteur);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ListTile(
                          leading: ProfileImage(myUser: author, size: 20),
                          title: Text(
                            notif.notification!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Divider(color: Colors.black),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
  }
}
