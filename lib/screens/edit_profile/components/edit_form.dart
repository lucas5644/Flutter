import 'package:flutter/material.dart';
import 'package:flutter_social/models/my_user.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

import '../../../enums.dart';
import 'profile_photo.dart';

class EditForm extends StatefulWidget {
  const EditForm({Key? key}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _keyForm = GlobalKey<FormState>();
  List<String> errors = [];
  TextEditingController? _prenomController;
  TextEditingController? _nomController;
  TextEditingController? _descriptionController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _prenomController = TextEditingController();
    _nomController = TextEditingController();
    _descriptionController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _prenomController!.dispose();
    _nomController!.dispose();
    _descriptionController!.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<MyUser?>(context);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _keyForm,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfilePhoto(myUser: currentUser!),
                  SizedBox(height: 20),
                  buildFormField("${currentUser.prenom}", "Prénom", _prenomController, false),
                  SizedBox(height: 20),
                  buildFormField("${currentUser.nom}", "Nom", _nomController, false),
                  SizedBox(height: 20),
                  buildFormField((currentUser.description != null) ? "${currentUser.description}" : "Ajouter une description...", "Description",
                      _descriptionController, false),
                  SizedBox(height: 20),
                  CustomButton(
                    text: "Mettre à jour",
                    onTap: () {
                      _keyForm.currentState!.save();
                      Map<String, dynamic> map = {
                        keyUid: currentUser.uid,
                        keyPrenom: (_prenomController!.text.isNotEmpty) ? _prenomController!.text : currentUser.prenom,
                        keyNom: (_nomController!.text.isNotEmpty) ? _nomController!.text : currentUser.nom,
                        keyEmail: currentUser.email,
                        keyImageUrl: currentUser.imageUrl,
                        keyDescription: (_descriptionController!.text.isNotEmpty) ? _descriptionController!.text : currentUser.description,
                        keyAbonnements: currentUser.abonnements,
                        keyAbonnes: currentUser.abonnes,
                      };
                      Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.profile);
                      FirestoreHelper().addUser(map, currentUser.uid);
                    },
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildFormField(String text, String champ, TextEditingController? controller, bool obscure) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [BoxShadow(offset: Offset(2, 4), color: Colors.grey[700]!.withOpacity(0.15), blurRadius: 8)],
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: obscure,
        controller: controller,
        keyboardType: TextInputType.text,
        onSaved: (newValue) => controller!.text = newValue!.trim(),
        maxLines: null,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 16),
          hintText: text,
          labelText: champ,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
