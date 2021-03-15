import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/models/notification.dart';
import 'package:flutter_social/models/post.dart';
import 'package:flutter_social/view/my_material.dart';

class FirestoreHelper {
  //Authentification
  //Instance de Firebase Auth
  final authInstance = FirebaseAuth.instance;

  //Fonction pour se connecter
  signIn(String email, String password) async {
    UserCredential user;
    try {
      user = await authInstance.signInWithEmailAndPassword(email: email, password: password);
      print("user :" + user.additionalUserInfo.toString());
    } catch (e) {
      // FirebaseAuthException exception = e;
      // print(exception.code);
      // return exception.code;
    }
  }

  //Fonction pour créer un compte
  Future<UserCredential> createAccount(String email, String password, String prenom, String nom) async {
    final UserCredential userCredential = await authInstance.createUserWithEmailAndPassword(email: email, password: password);
    final User user = userCredential.user!;
    //Création du user en BDD
    String uid = user.uid;
    List<dynamic> followers = [uid];
    List<dynamic> following = [uid];
    Map<String, dynamic> map = {
      keyUid: uid,
      keyNom: nom,
      keyPrenom: prenom,
      keyEmail: email,
      keyImageUrl: "",
      keyAbonnes: followers,
      keyAbonnements: following,
    };
    addUser(map, uid);
    return userCredential;
  }

  //Fonction pour se déconnecter
  void logOut() => authInstance.signOut();

  //Database
  //Instance de cloud firestore
  static final firestoreInstance = FirebaseFirestore.instance;
  final firestoreUser = firestoreInstance.collection("users");

  addUser(Map<String, dynamic> map, String? uid) {
    firestoreUser.doc(uid).set(map);
  }

  publishPost(String? uid, String contenu, String? imageUrl) {
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    List<dynamic> likes = [];
    List<dynamic> comments = [];
    Map<String, dynamic> map = {
      keyUid: uid,
      keyContenuPost: contenu,
      keyDatePost: date,
      keyLikes: likes,
      keyComments: comments,
    };
    if (imageUrl != null) {
      map[keyImageUrl] = imageUrl;
    }
    firestoreUser.doc(uid).collection("posts").doc().set(map);
  }

  followUnfollowUser(MyUser myUser, MyUser other) {
    if (myUser.abonnements.contains(other.uid)) {
      myUser.reference.update({
        keyAbonnements: FieldValue.arrayRemove([other.uid])
      });
      other.reference.update({
        keyAbonnes: FieldValue.arrayRemove([myUser.uid])
      });
    } else {
      Map<String, dynamic> map = {
        keyUid: other.uid,
        keyNotification: "${myUser.prenom} ${myUser.nom} s'est abonné(e) à vous",
        keyDateNotif: DateTime.now().millisecondsSinceEpoch.toString(),
        keyExpediteur: myUser.uid,
      };
      firestoreUser.doc(other.uid).collection("notifications").doc().set(map);
      myUser.reference.update({
        keyAbonnements: FieldValue.arrayUnion([other.uid])
      });
      other.reference.update({
        keyAbonnes: FieldValue.arrayUnion([myUser.uid])
      });
    }
  }

  likePost(MyUser currentUser, MyUser author, Post selectedPost) {
    if (selectedPost.likes!.contains(currentUser.uid)) {
      selectedPost.reference.update({
        keyLikes: FieldValue.arrayRemove([currentUser.uid])
      });
    } else {
      Map<String, dynamic> map = {
        keyUid: author.uid,
        keyNotification: "${currentUser.prenom} ${currentUser.nom} a liké votre publication",
        keyDateNotif: DateTime.now().millisecondsSinceEpoch.toString(),
        keyExpediteur: currentUser.uid,
      };
      firestoreUser.doc(author.uid).collection("notifications").doc("").set(map);
      selectedPost.reference.update({
        keyLikes: FieldValue.arrayUnion([currentUser.uid])
      });
    }
  }

  deleteNotification(String notifId) {
    firestoreUser.doc(authInstance.currentUser!.uid).collection("notifications").doc(notifId).delete();
  }

  Stream<List<MyUser>> get abonnements {
    return firestoreUser.where(keyAbonnes, arrayContains: authInstance.currentUser!.uid).snapshots().map((usersData) => usersData.docs.map((user) {
          return MyUser(user);
        }).toList());
  }

  Stream<List<MyUser>> get allUsers {
    return firestoreUser.snapshots().map((usersData) => usersData.docs.map((user) {
          return MyUser(user);
        }).toList());
  }

  Future<List<dynamic>> getAbonnements() async {
    var document = firestoreUser.doc(authInstance.currentUser!.uid);
    return document.get().then((value) {
      return value[keyAbonnements];
    });
  }

  Stream<List<Post>> posts(List<dynamic> abonnements) {
    return firestoreInstance
        .collectionGroup("posts")
        .orderBy(keyDatePost, descending: true)
        .snapshots()
        .map((postData) => postData.docs.where((element) => abonnements.contains(element.data()![keyUid])).map((post) {
              return Post(post);
            }).toList());
  }

  getUser(String uid) {
    return firestoreUser.doc(uid).get().then((value) {
      return MyUser(value);
    });
  }

  Stream<List<Notif>> get notifs {
    return firestoreInstance
        .collectionGroup("notifications")
        .snapshots()
        .map((snaps) => snaps.docs.where((element) => element.data()!["uid"] == authInstance.currentUser!.uid).map((notif) {
              return Notif(notif);
            }).toList());
  }

  Stream<QuerySnapshot> allUserPosts(String? uid) {
    return firestoreUser.doc(uid).collection("posts").orderBy("date", descending: true).snapshots();
  }

  Stream<Post> getPost(MyUser user, Post post) {
    return firestoreUser.doc(user.uid).collection("posts").doc(post.documentId).snapshots().map((event) => Post(event));
  }

  //Storage
  static final entryStorage = FirebaseStorage.instance.ref();
  final entryStorageUser = entryStorage.child("users");
  final entryStoragePost = entryStorage.child("publications");

  Future<String> savePicture(File file, Reference reference) async {
    UploadTask task = reference.putFile(file);
    TaskSnapshot snapshot = await task;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
