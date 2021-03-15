import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color? buttonColor;
  final bool border;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.buttonColor,
    this.border = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 1.6,
        height: 50,
        decoration: BoxDecoration(
          color: (buttonColor == null) ? Color(0xFFFFA53E) : buttonColor,
          borderRadius: BorderRadius.circular(15),
          border: (!border) ? null : Border.all(color: Color(0xFFFFA53E), width: 2),
        ),
        child: Text(text, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
