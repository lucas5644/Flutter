import 'package:flutter/material.dart';
import 'dart:math';

class MyPainter extends CustomPainter {
  Paint painter = Paint();
  final PageController? pageController;

  MyPainter(this.pageController) : super(repaint: pageController) {
    painter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (pageController != null && pageController!.position != null) {
      final radius = 20.0;
      final dy = 25.0;
      final dxCurrent = 25.0;
      final dxTarget = 135.0;
      final position = pageController!.position;
      final extent = (position.maxScrollExtent - position.minScrollExtent + position.viewportDimension);
      final offset = position.extentBefore / extent;
      Offset entry = Offset(dxCurrent, dy);
      Offset target = Offset(dxTarget, dy);
      Path path = Path();
      path.addArc(Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
      path.addRect(Rect.fromLTRB(entry.dy, dy - radius, target.dx, dy + radius));
      path.addArc(Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);
      canvas.translate(size.width * offset, 0.0);
      canvas.drawShadow(path, Colors.black, 2.5, true);
      canvas.drawPath(path, painter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
