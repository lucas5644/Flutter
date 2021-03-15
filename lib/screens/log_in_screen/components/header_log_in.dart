import 'package:flutter/material.dart';
import 'package:flutter_social/provider/log_in_state_model.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

class HeaderLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var page = Provider.of<LogInStateModel>(context).page;
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: lPrimaryGradientColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120)),
      ),
      child: Column(
        children: [
          Spacer(),
          Image(image: logoImage, height: 80, color: Colors.white),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text((page != 1) ? "Connexion" : "Créer mon compte",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
