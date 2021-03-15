import 'package:flutter/material.dart';

const lPrimaryColor = Color(0xFFFF007F);
const lPrimaryLightColor = Color(0xFFFFECDF);
const lPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const lSecondaryColor = Color(0xFF979797);
const lTextColor = Color(0xFF757575);
const lAnimationDuration = Duration(milliseconds: 300);

final headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

//Icons
IconData homeIcon = Icons.home_rounded;
IconData feedIcon = Icons.group;
IconData notifIcon = Icons.notifications;
IconData profilIcon = Icons.account_circle;
IconData writeIcon = Icons.border_color;
IconData sendIcon = Icons.send_rounded;
IconData cameraIcon = Icons.camera_enhance_rounded;
IconData libraryIcon = Icons.photo_library_rounded;
IconData likeFullIcon = Icons.favorite_rounded;
IconData likeEmptyIcon = Icons.favorite_outline_rounded;
IconData messageIcon = Icons.comment_rounded;
IconData logOutIcon = Icons.logout;

//Images
AssetImage logoImage = AssetImage("assets/darkBee.png");
AssetImage eventImage = AssetImage("assets/event.jpg");
AssetImage homeImage = AssetImage("assets/home.jpg");
AssetImage profileImage = AssetImage("assets/profile.jpg");
AssetImage couvertureImage = AssetImage("assets/cumulus-cloud.jpg");

//Erreurs
const lErrorEmailEmpty = "Vous n'avez pas saisi votre email";
const lErrorPasswordEmpty = "Vous n'avez pas saisi votre mot de passe";
const lErrorPrenomEmpty = "Vous n'avez pas saisi votre prénom";
const lErrorNomEmpty = "Vous n'avez pas saisi votre nom";
const lErrorMessageEmpty = "Vous n'avez pas saisi de texte";
const lErrorLengthMessage = "Votre message ne doit pas excéder 140 caractères";

//Firestore keys
String keyUid = "uid";
String keyNom = "nom";
String keyPrenom = "prenom";
String keyEmail = "email";
String keyImageUrl = "imageUrl";
String keyAbonnes = "abonnés";
String keyAbonnements = "abonnements";
String keyContenuPost = "post";
String keyDatePost = "date";
String keyPostId = "postId";
String keyLikes = "likes";
String keyComments = "comments";
String keyDescription = "description";
String keyNotification = "notification";
String keyDateNotif = "date";
String keyExpediteur = "expediteur";
