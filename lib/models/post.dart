import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social/view/my_widgets/constants.dart';

class Post {
  late DocumentReference reference;
  String? documentId;
  String? id;
  String? imageUrl;
  String? contenu;
  String? date;
  List<dynamic>? likes;
  List<dynamic>? comments;
  String? uid;

  Post(DocumentSnapshot snapshot) {
    reference = snapshot.reference;
    documentId = snapshot.id;
    Map<String, dynamic> map = snapshot.data()!;
    id = map[keyPostId];
    imageUrl = map[keyImageUrl];
    contenu = map[keyContenuPost];
    date = map[keyDatePost];
    likes = map[keyLikes];
    comments = map[keyComments];
    uid = map[keyUid];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      keyPostId: id,
      keyUid: uid,
      keyImageUrl: imageUrl,
      keyContenuPost: contenu,
      keyDatePost: date,
      keyComments: comments,
      keyLikes: likes,
    };
    if (imageUrl != null) {
      map[keyImageUrl] = imageUrl;
    }
    return map;
  }
}
