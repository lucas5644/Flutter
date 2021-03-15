import 'package:flutter/material.dart';

class CustomPrefixIcon extends StatelessWidget {
  final Icon icon;
  const CustomPrefixIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: icon,
    );
  }
}
