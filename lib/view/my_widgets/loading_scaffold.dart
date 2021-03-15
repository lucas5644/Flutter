import 'package:flutter/material.dart';

class LoadingScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Chargement",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
