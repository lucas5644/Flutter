import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> disconnect(BuildContext context) async {
  Text content = Text("Me déconnecter ?", style: TextStyle(fontSize: 18));
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              FirestoreHelper().logOut();
              Navigator.pop(context);
            },
            child: Text("Oui", style: TextStyle(fontSize: 14, color: Colors.black)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Non", style: TextStyle(fontSize: 14, color: Colors.black)),
          ),
        ],
      );
    },
  );
}

Future<void> changePhoto(BuildContext context, MyUser myUser) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(cameraIcon, size: 35),
                onPressed: () {
                  takePicture(ImageSource.camera, myUser);
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: Icon(libraryIcon, size: 35),
                onPressed: () {
                  takePicture(ImageSource.gallery, myUser);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> takePicture(ImageSource imageSource, MyUser myUser) async {
  PickedFile? image = await ImagePicker().getImage(source: imageSource, maxHeight: 1000, maxWidth: 1000);
  if (image != null) {
    File file = File(image.path);
    Reference reference = FirestoreHelper().entryStorageUser.child(myUser.uid);
    FirestoreHelper().savePicture(file, reference).then((value) {
      Map map = myUser.toMap();
      map[keyImageUrl] = value;
      FirestoreHelper().addUser(map as Map<String, dynamic>, myUser.uid);
    });
  }
}
