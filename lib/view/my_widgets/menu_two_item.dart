import 'package:flutter/material.dart';
import 'package:flutter_social/provider/log_in_state_model.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:provider/provider.dart';

class MenuTwoItems extends StatelessWidget {
  final String item1;
  final String item2;
  final PageController? pageController;

  const MenuTwoItems({
    Key? key,
    required this.item1,
    required this.item2,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 50,
      decoration: BoxDecoration(color: Color(0xFFFFA53E), borderRadius: BorderRadius.circular(25)),
      child: CustomPaint(
        painter: MyPainter(pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            itemButton(item1, context),
            itemButton(item2, context),
          ],
        ),
      ),
    );
  }

  Expanded itemButton(String name, BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          int page = (pageController!.page == 0) ? 1 : 0;
          pageController!.animateToPage(page, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
          Provider.of<LogInStateModel>(context, listen: false).notifyPageChanged(page);
        },
        child: Text(name, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
