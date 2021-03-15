import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/selected_user.dart';
import 'package:flutter_social/screens/profile/components/body.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:provider/provider.dart';

class ProfilDetailsScreen extends StatelessWidget {
  static String routeName = "/profile-detail";

  const ProfilDetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ProfilDetailsArgument arguments = ModalRoute.of(context)!.settings.arguments as ProfilDetailsArgument;
    return MultiProvider(
      providers: [
        StreamProvider<SelectedUser?>.value(
          initialData: null,
          value: FirestoreHelper().firestoreUser.doc(arguments.userSelected.uid).snapshots().map((event) => SelectedUser(MyUser(event))),
        ),
        StreamProvider<MyUser?>.value(
          initialData: null,
          value: FirestoreHelper().firestoreUser.doc(arguments.userConnected.uid).snapshots().map((event) => MyUser(event)),
        ),
      ],
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}

class ProfilDetailsArgument {
  final MyUser userSelected;
  final MyUser userConnected;
  ProfilDetailsArgument({required this.userSelected, required this.userConnected});
}
