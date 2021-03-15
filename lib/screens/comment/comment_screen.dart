import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/post.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class CommentScreen extends StatelessWidget {
  static String routeName = "/comment";
  const CommentScreen({Key? key}) : super();
  @override
  Widget build(BuildContext context) {
    final CommentArguments arguments = ModalRoute.of(context)!.settings.arguments as CommentArguments;
    return Scaffold(
      body: MultiProvider(
        providers: [
          StreamProvider<Post?>.value(
            initialData: null,
            value: FirestoreHelper().getPost(arguments.selectedUser, arguments.post!),
          ),
          StreamProvider<MyUser?>.value(
            initialData: null,
            value: FirestoreHelper().firestoreUser.doc(FirebaseAuth.instance.currentUser!.uid).snapshots().map(
                  (event) => MyUser(event),
                ),
          ),
        ],
        child: Body(selectedUser: arguments.selectedUser),
      ),
    );
  }
}

class CommentArguments {
  final MyUser selectedUser;
  final Post? post;

  CommentArguments(this.selectedUser, this.post);
}
