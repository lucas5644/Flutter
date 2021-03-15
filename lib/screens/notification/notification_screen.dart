import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';

import 'package:flutter_social/models/notification.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = "/notification";

  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Notif>>.value(
          initialData: [],
          value: FirestoreHelper().notifs,
        ),
        StreamProvider<List<MyUser>>.value(
          initialData: [],
          value: FirestoreHelper().allUsers,
        ),
      ],
      child: Body(),
    );
  }
}
