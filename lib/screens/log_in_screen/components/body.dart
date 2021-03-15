import 'package:flutter/material.dart';
import 'package:flutter_social/provider/log_in_state_model.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

import 'header_log_in.dart';
import 'log_in_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      // onNotification: (overscroll) {
      //   overscroll.disallowGlow();
      // } as bool Function(OverscrollIndicatorNotification),
      child: SingleChildScrollView(
        child: InkWell(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            height: (MediaQuery.of(context).size.height >= 650) ? MediaQuery.of(context).size.height : 650,
            width: double.infinity,
            color: Colors.grey[50],
            child: SafeArea(
              child: Column(
                children: [
                  HeaderLogin(),
                  SizedBox(height: 15),
                  MenuTwoItems(item1: "Connexion", item2: "Créer un compte", pageController: _pageController),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      onPageChanged: (value) {
                        Provider.of<LogInStateModel>(context, listen: false).notifyPageChanged(value);
                      },
                      controller: _pageController,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          child: LoginForm(index: 0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          child: LoginForm(index: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
