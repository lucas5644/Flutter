import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social/view/my_material.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'myUser.g.dart';

// @JsonSerializable()
class MyUser {
  String uid = "";
  String prenom = "";
  String nom = "";
  String email = "";
  String? imageUrl;
  String? description;
  List<dynamic> abonnes = [];
  List<dynamic> abonnements = [];
  late DocumentReference reference;
  String documentId = "";

  MyUser(DocumentSnapshot snapshot) {
    reference = snapshot.reference;
    documentId = snapshot.id;
    Map<String, dynamic> map = snapshot.data()!;
    uid = map[keyUid];
    prenom = map[keyPrenom];
    nom = map[keyNom];
    email = map[keyEmail];
    description = map[keyDescription];
    imageUrl = map[keyImageUrl];
    abonnes = map[keyAbonnes];
    abonnements = map[keyAbonnements];
  }

  Map<String, dynamic> toMap() {
    return {
      keyUid: uid,
      keyPrenom: prenom,
      keyNom: nom,
      keyEmail: email,
      keyImageUrl: imageUrl,
      keyDescription: description,
      keyAbonnes: abonnes,
      keyAbonnements: abonnements,
    };
  }

  // MyUser(this.uid, this.prenom, this.nom, this.email, this.imageUrl, this.description, this.abonnes, this.abonnements, this.documentId);

  // factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  // Map<String, dynamic> toJson() => _$MyUserToJson(this);

  // factory MyUser.fromFirestore(DocumentSnapshot snapshot) {
  //   MyUser myUser = MyUser.fromJson(snapshot.data()!);
  //   myUser.uid = snapshot.id;
  //   return myUser;
  // }
}
