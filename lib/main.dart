import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_social/provider/menu_state_model.dart';
import 'package:flutter_social/routes.dart';
import 'package:flutter_social/screens/landing/landing_screen.dart';
import 'package:flutter_social/screens/log_in_screen/log_in_screen.dart';
import 'package:flutter_social/theme.dart';
import 'package:flutter_social/util/firestore_helper.dart';
import 'package:provider/provider.dart';

import 'models/my_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      StreamProvider<User?>.value(initialData: null, value: FirebaseAuth.instance.authStateChanges()),
      ChangeNotifierProvider(create: (_) => MenuStateModel()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      home: _handleAuth(context),
      routes: routes,
    );
  }

  Widget _handleAuth(BuildContext context) {
    var user = Provider.of<User?>(context);

    bool loggedIn = user != null;
    print("Connecté : " + loggedIn.toString());
    if (!loggedIn) {
      return LogInScreen();
    }

    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: FirestoreHelper().firestoreUser.doc(user.uid).snapshots().map(
            (event) => MyUser(event),
          ),
      builder: (context, child) {
        return LandingScreen();
      },
    );
  }
}
