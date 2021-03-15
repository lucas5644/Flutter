import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/enums.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/post.dart';
import 'package:flutter_social/models/selected_user.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

import 'my_header_delegate.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController? scrollController;
  double expanded = 200.0;
  bool get _showTitle {
    return scrollController!.hasClients && scrollController!.offset > expanded - kToolbarHeight;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(
        () {
          //Le setState permet de tout remettre à jour lors du scroll
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDetailPage = (Provider.of<MenuStateModel>(context).menuState == MenuState.profile) ? false : true;
    var selectedUser = (isDetailPage) ? Provider.of<SelectedUser?>(context) : null;
    var connectedUser = Provider.of<MyUser?>(context);
    return ((selectedUser == null && connectedUser == null) || (connectedUser == null))
        ? LoadingScaffold()
        : SafeArea(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirestoreHelper().allUserPosts((isDetailPage) ? selectedUser!.selectedUser.uid : connectedUser.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return (Center(
                    child: LoadingScaffold(),
                  ));
                } else {
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      CustomSliverAppBar(
                          showTitle: _showTitle, userSelected: (isDetailPage) ? selectedUser!.selectedUser : connectedUser, expanded: expanded),
                      SliverPersistentHeader(
                        delegate: (isDetailPage)
                            ? MyHeaderDelegate(FirebaseAuth.instance.currentUser, null, _showTitle, selectedUser!.selectedUser, connectedUser)
                            : MyHeaderDelegate(FirebaseAuth.instance.currentUser, null, _showTitle, connectedUser, null),
                        pinned: true,
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index >= documents.length) {
                              return null;
                            }
                            return ListTile(
                              title: PostTile(
                                author: (isDetailPage) ? selectedUser!.selectedUser : connectedUser,
                                post: Post(documents[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          );
  }
}
