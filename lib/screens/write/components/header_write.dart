import 'package:flutter/material.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

import '../../../enums.dart';

class HeaderWrite extends StatelessWidget {
  const HeaderWrite({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.errors,
    this.contenuController,
    this.uid,
    this.imageUrl,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final List<String> errors;
  final TextEditingController? contenuController;
  final String? uid;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.home);
          },
          child: Container(
            alignment: Alignment.center,
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.orange[400],
            ),
            child: Icon(Icons.close_rounded, color: Colors.black),
          ),
        ),
        Text(
          "Écrivez quelque chose...",
          style: TextStyle(color: lTextColor, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Container(
          width: 110,
          height: 30,
          child: CustomButton(
            text: "Publier",
            onTap: () {
              if (_formKey.currentState!.validate() && errors.length < 1) {
                Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.home);
                _formKey.currentState!.save();
                FirestoreHelper().publishPost(uid, contenuController!.text, imageUrl);
              }
            },
          ),
        )
      ],
    );
  }
}
