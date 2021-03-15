import 'package:flutter/material.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

import '../../../enums.dart';

class LoginForm extends StatefulWidget {
  final int index;

  const LoginForm({Key? key, required this.index}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _mailController;
  TextEditingController? _passwordController;
  TextEditingController? _prenomController;
  TextEditingController? _nomController;
  List<String> errors = [];
  late FirestoreHelper _firestoreHelper;

  @override
  void initState() {
    super.initState();
    _mailController = TextEditingController();
    _passwordController = TextEditingController();
    _prenomController = TextEditingController();
    _nomController = TextEditingController();
    _firestoreHelper = FirestoreHelper();
  }

  @override
  void dispose() {
    _mailController!.dispose();
    _passwordController!.dispose();
    _prenomController!.dispose();
    _nomController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: (widget.index == 0)
            ? Column(
                children: [
                  buildFormField(
                      "Saisir votre adresse mail", Icon(Icons.mail_sharp), _mailController, false, lErrorEmailEmpty, TextInputType.emailAddress),
                  SizedBox(height: 15),
                  buildFormField("Saisir votre mot de passe", Icon(Icons.lock_outline_sharp), _passwordController, true, lErrorPasswordEmpty,
                      TextInputType.text),
                  SizedBox(height: 15),
                  FormError(errors: errors),
                  SizedBox(height: 15),
                  CustomButton(
                    text: "Se connecter",
                    onTap: () {
                      if (_formKey.currentState!.validate() && errors.length < 1) {
                        _formKey.currentState!.save();
                        Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.home);
                        _firestoreHelper.signIn(_mailController!.text, _passwordController!.text).then((value) {
                          if (value != null) {
                            showSnackBar(value);
                          }
                        });
                      }
                    },
                  ),
                ],
              )
            : Column(
                children: [
                  buildFormField(
                      "Saisir votre prénom", Icon(Icons.account_circle_sharp), _prenomController, false, lErrorPrenomEmpty, TextInputType.text),
                  SizedBox(height: 15),
                  buildFormField("Saisir votre nom", Icon(Icons.account_circle_sharp), _nomController, false, lErrorNomEmpty, TextInputType.text),
                  SizedBox(height: 15),
                  buildFormField(
                      "Saisir votre adresse mail", Icon(Icons.mail_sharp), _mailController, false, lErrorEmailEmpty, TextInputType.emailAddress),
                  SizedBox(height: 15),
                  buildFormField(
                      "Saisir votre mot de passe", Icon(Icons.lock_sharp), _passwordController, true, lErrorPasswordEmpty, TextInputType.text),
                  SizedBox(height: 15),
                  FormError(errors: errors),
                  SizedBox(height: 15),
                  CustomButton(
                    text: "Créer un compte",
                    onTap: () {
                      if (_formKey.currentState!.validate() && errors.length < 1) {
                        _formKey.currentState!.save();
                        Provider.of<MenuStateModel>(context, listen: false).notifyMenuStateChanged(MenuState.home);
                        _firestoreHelper.createAccount(_mailController!.text, _passwordController!.text, _prenomController!.text, _nomController!.text);
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Container buildFormField(String text, Icon icon, TextEditingController? controller, bool obscure, String error, TextInputType textInputType) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [BoxShadow(offset: Offset(2, 4), color: Colors.grey[700]!.withOpacity(0.15), blurRadius: 8)],
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 12),
        obscureText: obscure,
        controller: controller,
        keyboardType: textInputType,
        onSaved: (newValue) => controller!.text = newValue!.trim(),
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(error)) {
            setState(() {
              errors.remove(error);
            });
          }
          return null;
        },
        validator: (value) {
          if ((value!.trim().isEmpty && !errors.contains(error))) {
            setState(() {
              errors.add(error);
            });
          }
          return null;
        },
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 14),
          hintText: text,
          prefixIcon: CustomPrefixIcon(icon: icon),
        ),
      ),
    );
  }

  showSnackBar(String code) async {
    String error;
    switch (code) {
      case "too-many-requests":
        error = "Authentification verrouillée. Réessayez plus tard.";
        break;
      case "wrong-password":
        error = "Identifiants incorrects.";
        break;
      default:
        error = "Une erreur s'est produite. Réessayez plus tard.";
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      ),
    );
  }
}
