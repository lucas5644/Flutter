import 'package:flutter/material.dart';

class MyGradient extends BoxDecoration {
  MyGradient({required Color startColor, required Color endColor, bool horizontal: false, double radius: 0.0})
      : super(
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(radius));
}
