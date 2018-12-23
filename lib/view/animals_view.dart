import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/view/start_view.dart';
import 'package:flutter_animate/helper/help_view.dart';

class AnimalView extends CustomPainter {
  Paint mPaint;
  BuildContext context;
  double _R;

  AnimalView(this.context, double r) {
    mPaint = new Paint();
    mPaint.color = Colors.deepOrange;
    _R = r;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var winSize = MediaQuery.of(context).size;
    drawGrid(canvas, winSize, mPaint);
    drawCoo(canvas, winSize, mPaint);
    drawRegularStar(canvas, mPaint, 5, _R);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
