import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/post.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

class PostContent extends StatefulWidget {
  final MyUser userConnected;

  const PostContent({
    Key? key,
    required this.userConnected,
  }) : super(key: key);

  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  // late StreamSubscription postStream;
  // List<Post> listPosts = [];
  // List<MyUser> listUsers = [];
  List<dynamic> abonnements = [];

  @override
  void initState() {
    // setupPostStream();
    super.initState();
    FirestoreHelper().getAbonnements().then((value) {
      setState(() {
        abonnements = value;
      });
    });
  }

  @override
  void dispose() {
    // postStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<MyUser>>.value(
          initialData: [],
          value: FirestoreHelper().abonnements,
        ),
        StreamProvider<List<Post>>.value(
          initialData: [],
          value: (abonnements.isNotEmpty) ? FirestoreHelper().posts(abonnements) : null,
        ),
      ],
      builder: (context, child) {
        var users = Provider.of<List<MyUser>>(context);
        var posts = Provider.of<List<Post>>(context);
        return (users.isEmpty || posts.isEmpty)
            ? LoadingScaffold()
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Post post = posts[index];
                  MyUser user = users.singleWhere((element) => element.uid == post.uid);
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      ListTile(title: PostTile(author: user, post: post)),
                    ],
                  );
                },
              );
      },
    );

    //   return ListView.builder(
    //     itemCount: listPosts.length,
    //     itemBuilder: (context, index) {
    //       Post post = listPosts[index];
    //       MyUser user = listUsers.singleWhere((element) => element.uid == post.uid);
    //       return Column(
    //         children: [
    //           SizedBox(height: 10),
    //           ListTile(title: PostTile(author: user, post: post)),
    //         ],
    //       );
    //     },
    //   );
    // }

    // setupPostStream() {
    //   postStream = FirestoreHelper().firestoreUser.where(keyAbonnes, arrayContains: widget.userConnected.uid).snapshots().listen((userDatas) {
    //     getUsers(userDatas.docs);
    //     userDatas.docs.forEach((user) {
    //       user.reference.collection("posts").snapshots().listen((postDatas) {
    //         if (this.mounted) {
    //           setState(() {
    //             listPosts = getPosts(postDatas.docs);
    //             listPosts.sort((a, b) => b.date!.compareTo(a.date!));
    //           });
    //         }
    //       });
    //     });
    //   });
    // }

    // getUsers(List<DocumentSnapshot> userDocs) {
    //   List<MyUser> users = listUsers;
    //   userDocs.forEach((u) {
    //     MyUser user = MyUser(u);
    //     if (users.every((element) => element.uid != user.uid)) {
    //       users.add(user);
    //     } else {
    //       MyUser userToBeChanged = users.singleWhere((element) => element.uid == user.uid);
    //       users.remove(userToBeChanged);
    //       users.add(user);
    //     }
    //     setState(() {
    //       users = listUsers;
    //     });
    //   });
    // }

    // List<Post> getPosts(List<DocumentSnapshot> postDocs) {
    //   List<Post> posts = listPosts;
    //   postDocs.forEach((p) {
    //     Post post = Post(p);
    //     //Si le post ne figure pas dans la liste, je l'ajoute
    //     if (posts.every((element) => element.documentId != post.documentId)) {
    //       posts.add(post);
    //       //S'il figure dans la liste, je le supprime puis le rajoute
    //     } else {
    //       //Je récupère le post à supprimer
    //       Post toBeChanged = posts.singleWhere((element) => element.documentId == post.documentId);
    //       //Je le supprime...
    //       posts.remove(toBeChanged);
    //       //puis j'ajoute le post à jour ayant pu subir des modifs'
    //       posts.add(post);
    //     }
    //   });
    //   return posts;
    // }
  }
}
