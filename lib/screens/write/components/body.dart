import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'header_write.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _contenuController;
  List<String> errors = [];
  String? text;
  String? postImageUrl;
  int textLength = 0;

  @override
  void initState() {
    super.initState();
    _contenuController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<MyUser?>(context);
    ImageProvider userProvider = CachedNetworkImageProvider(currentUser!.imageUrl!);

    return SafeArea(
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      HeaderWrite(
                          formKey: _formKey,
                          errors: errors,
                          imageUrl: (postImageUrl == null) ? "" : postImageUrl,
                          contenuController: _contenuController,
                          uid: currentUser.uid),
                      SizedBox(height: 10),
                      Divider(height: 1, color: Colors.black),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: userProvider,
                                ),
                              ),
                              buildFormField("Écrivez votre message ici...", _contenuController, lErrorMessageEmpty),
                            ],
                          ),
                          SizedBox(height: 15),
                          FormError(errors: errors),
                          SizedBox(height: 15),
                          Container(
                            height: 190,
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.50)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.50))),
                                    color: Colors.grey[200],
                                  ),
                                  width: double.infinity,
                                  height: 140,
                                  child: (postImageUrl == null)
                                      ? Icon(Icons.no_photography_rounded, size: 60, color: Colors.grey[400])
                                      : Image(image: CachedNetworkImageProvider(postImageUrl!)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        icon: Icon(cameraIcon, size: 25),
                                        onPressed: () {
                                          takePicture(currentUser, ImageSource.camera);
                                        }),
                                    IconButton(
                                      icon: Icon(libraryIcon, size: 25),
                                      onPressed: () {
                                        takePicture(currentUser, ImageSource.gallery);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildFormField(String text, TextEditingController? controller, String error) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                style: TextStyle(fontSize: 16),
                maxLines: null,
                focusNode: FocusNode(),
                autofocus: true,
                controller: controller,
                keyboardType: TextInputType.text,
                onSaved: (newValue) => controller!.text = newValue!.trim(),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      textLength = value.length;
                    });
                  }
                  if (value.isNotEmpty && errors.contains(error)) {
                    setState(
                      () {
                        errors.remove(error);
                      },
                    );
                  } else if (value.length <= 140 && errors.contains(lErrorLengthMessage)) {
                    setState(() {
                      errors.remove(lErrorLengthMessage);
                    });
                  }
                  return null;
                },
                validator: (value) {
                  if ((value!.trim().isEmpty && !errors.contains(error))) {
                    setState(() {
                      errors.add(error);
                    });
                  } else if (value.length > 140 && !errors.contains(lErrorLengthMessage)) {
                    setState(
                      () {
                        errors.add(lErrorLengthMessage);
                      },
                    );
                  }
                  return null;
                },
                decoration: InputDecoration.collapsed(
                  hintStyle: TextStyle(fontSize: 16),
                  hintText: text,
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text("$textLength/140")],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> takePicture(MyUser currentUser, ImageSource imageSource) async {
    PickedFile? image = await ImagePicker().getImage(source: imageSource, maxHeight: 1000, maxWidth: 1000);
    if (image != null) {
      String date = DateTime.now().millisecondsSinceEpoch.toString();
      File file = File(image.path);
      Reference reference = FirestoreHelper().entryStoragePost.child(currentUser.uid).child(date);
      FirestoreHelper().savePicture(file, reference).then((value) {
        setState(() {
          postImageUrl = value;
        });
      });
    }
  }
}
