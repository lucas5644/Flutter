import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous n'avez pas encore de compte ? ",
          style: TextStyle(color: lTextColor),
        ),
        GestureDetector(
          onTap: () {},
          child: Text("M'enregistrer", style: TextStyle(color: lPrimaryColor)),
        )
      ],
    );
  }
}
