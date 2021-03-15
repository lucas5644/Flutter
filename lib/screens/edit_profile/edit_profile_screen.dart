import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class EditProfilScreen extends StatelessWidget {
  static String routeName = "/edit-profile";

  const EditProfilScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
        initialData: null,
        value: FirestoreHelper().firestoreUser.doc(FirebaseAuth.instance.currentUser!.uid).snapshots().map(
              (event) => MyUser(event),
            ),
        child: Body());
  }
}
