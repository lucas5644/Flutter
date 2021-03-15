import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/screens/profile_details/profile_details_screen.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

class ListViewUsers extends StatefulWidget {
  const ListViewUsers({
    Key? key,
  }) : super(key: key);

  @override
  _ListViewUsersState createState() => _ListViewUsersState();
}

class _ListViewUsersState extends State<ListViewUsers> {
  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<MyUser?>(context);
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().firestoreUser.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                MyUser otherUser = MyUser(documents[index]);
                if (otherUser.uid == currentUser!.uid) {
                  return Container();
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, ProfilDetailsScreen.routeName,
                                      arguments: ProfilDetailsArgument(userSelected: otherUser, userConnected: currentUser));
                                },
                                child: ProfileImage(myUser: otherUser, size: 34, initialesSize: 25),
                              ),
                              SizedBox(width: 15),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 2.3,
                                          child: Text(
                                            "${otherUser.prenom} ${otherUser.nom}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 14, color: lTextColor, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        FollowButton(userSelected: otherUser, userConnected: currentUser),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      (otherUser.description != null) ? otherUser.description! : "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 1),
                        ],
                      ),
                    ),
                  );

                  // return StreamProvider<MyUser>.value(
                  //   value: FirestoreHelper().firestoreUser.doc(otherUser.uid).snapshots().map((event) => MyUser(event)),
                  //   builder: (context, child) {
                  //     var selectedUser = Provider.of<MyUser?>(context);
                  //     return Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 8),
                  //       child: Container(
                  //         child: Column(
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 GestureDetector(
                  //                   onTap: () {
                  //                     Navigator.pushNamed(context, ProfilDetailsScreen.routeName,
                  //                         arguments: ProfilDetailsArgument(userSelected: selectedUser, userConnected: currentUser));
                  //                   },
                  //                   child: ProfileImage(myUser: otherUser, size: 34, initialesSize: 25),
                  //                 ),
                  //                 SizedBox(width: 15),
                  //                 Flexible(
                  //                   child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       Row(
                  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                         children: [
                  //                           Container(
                  //                             width: MediaQuery.of(context).size.width / 2.3,
                  //                             child: Text(
                  //                               "${otherUser.prenom} ${otherUser.nom}",
                  //                               overflow: TextOverflow.ellipsis,
                  //                               style: TextStyle(fontSize: 14, color: lTextColor, fontWeight: FontWeight.w600),
                  //                             ),
                  //                           ),
                  //                           FollowButton(userSelected: otherUser, userConnected: currentUser),
                  //                         ],
                  //                       ),
                  //                       SizedBox(height: 8),
                  //                       Text(
                  //                         (otherUser.description != null) ? otherUser.description : "",
                  //                         maxLines: 2,
                  //                         overflow: TextOverflow.ellipsis,
                  //                         style: TextStyle(color: Colors.black, fontSize: 14),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             Divider(thickness: 1),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                }
              },
            );
          } else {
            return LoadingScaffold();
          }
        },
      ),
    );
  }
}
