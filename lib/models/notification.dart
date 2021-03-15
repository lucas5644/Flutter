import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social/view/my_material.dart';

class Notif {
  String? uid;
  String? expediteur;
  String? notification;
  String? date;
  late DocumentReference reference;
  String documentId = "";

  Notif(DocumentSnapshot snapshot) {
    reference = snapshot.reference;
    documentId = snapshot.id;
    Map<String, dynamic> map = snapshot.data()!;
    uid = map[keyUid];
    expediteur = map[keyExpediteur];
    notification = map[keyNotification];
    date = map[keyDateNotif];
  }

  Map<String, dynamic> toMap() {
    return {
      keyUid: uid,
      keyExpediteur: expediteur,
      keyNotification: notification,
      keyDateNotif: date,
    };
  }
}
