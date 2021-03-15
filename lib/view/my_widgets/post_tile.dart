import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/enums.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/post.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/screens/comment/comment_screen.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

class PostTile extends StatelessWidget {
  final Post? post;
  final MyUser author;
  final bool? detail;
  const PostTile({
    Key? key,
    this.post,
    required this.author,
    this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _globalKey = GlobalKey();
    var menuState = Provider.of<MenuStateModel>(context).menuState;
    var currentUser = Provider.of<MyUser?>(context);
    return Container(
      key: _globalKey,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [ProfileImage(myUser: author, size: 25)],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "${author.prenom} ${author.nom} - ",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                            children: [
                              TextSpan(text: convertDate(post!.date!), style: TextStyle(fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                        width: 300,
                        child: Row(mainAxisSize: MainAxisSize.max, children: [
                          Expanded(
                              child: Text(
                            "${post!.contenu}",
                            style: TextStyle(fontSize: 14),
                          ))
                        ])),
                    SizedBox(height: 10),
                    (post!.imageUrl == "")
                        ? SizedBox(height: 0)
                        : Container(
                            height: 180,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: CachedNetworkImageProvider(post!.imageUrl!), fit: BoxFit.cover),
                            ),
                          ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            FirestoreHelper().likePost(currentUser!, author, post!);
                          },
                          child: (post!.likes!.contains(currentUser!.uid) ? Icon(likeFullIcon, color: Colors.red) : Icon(likeEmptyIcon)),
                        ),
                        SizedBox(width: 5),
                        Text(post!.likes!.length.toString()),
                        SizedBox(width: 50),
                        (menuState != MenuState.comment)
                            ? Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.comment);
                                        Navigator.pushNamed(context, CommentScreen.routeName, arguments: CommentArguments(author, post));
                                      },
                                      child: Icon(messageIcon)),
                                  SizedBox(width: 5),
                                  Text(post!.comments!.length.toString())
                                ],
                              )
                            : Text((post!.comments!.length > 1) ? "${post!.comments!.length} commentaires" : "${post!.comments!.length} commentaire"),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(color: Colors.black),
        ],
      ),
    );
  }
}

convertDate(String date) {
  DateTime datePost = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
  DateTime now = DateTime.now().add(Duration(hours: 1));
  int daysSincePost = now.difference(datePost).inDays;
  if (daysSincePost >= 1) {
    return "$daysSincePost  j";
  }
  if (daysSincePost < 1) {
    int hoursSincePost = now.difference(datePost).inHours - 1;
    if (hoursSincePost >= 1) {
      return "$hoursSincePost h";
    }

    int minutesSincePost = now.difference(datePost).inMinutes - 60;
    if (minutesSincePost < 60) {
      return "$minutesSincePost min";
    }
  }
}
